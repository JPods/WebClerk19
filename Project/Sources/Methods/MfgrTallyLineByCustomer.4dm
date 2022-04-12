//%attributes = {}
If (False:C215)
	//MfgrTallyLineByCustomer
	Version_0508
	
End if 
C_LONGINT:C283($1; $doCarried)
$doCarried:=$1
C_BOOLEAN:C305($doMfrs; $doItemZip)
If ($doCarried=1)
	$k:=Records in selection:C76([OrderLine:49])
	CONFIRM:C162("Rebuild Manufacturers Carried By Zip for [OrderLine]: "+String:C10($k))
	If (OK=1)
		$doMfrs:=True:C214
		CONFIRM:C162("Delete Existing [MfrsCarried] records")
		If (OK=1)
			$doMfrsDelete:=True:C214
		End if 
	End if 
	
	If (($doItemZip) | ($doMfrs))
		OrdLn_Update
	End if 
	If ($doMfrs)
		If ($doMfrsDelete)
			ALL RECORDS:C47([MfrCustomerXRef:110])
			DELETE SELECTION:C66([MfrCustomerXRef:110])
		End if 
		//ThermoInitExit ("MfrCarried Information";$k;True)
		$viProgressID:=Progress New
		
		ORDER BY:C49([OrderLine:49]; [OrderLine:49]customerID:2; [OrderLine:49]orderNum:1; [OrderLine:49]class:53)
		FIRST RECORD:C50([OrderLine:49])
		For ($i; 1; $k)
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "MfrCarried Information")
			If (<>ThermoAbort)
				$i:=$k
			End if 
			If ([OrderLine:49]orderNum:1#[Order:3]orderNum:2)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
			End if 
			QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]class:9=[OrderLine:49]class:53; *)
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]customerID:2=[OrderLine:49]customerID:2; *)
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrid:3=[OrderLine:49]mfrid:52; *)
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]zipCustomer:8=[Order:3]zip:20)
			If (Records in selection:C76([MfrCustomerXRef:110])=0)
				CREATE RECORD:C68([MfrCustomerXRef:110])
				
				[MfrCustomerXRef:110]class:9:=[OrderLine:49]class:53
				[MfrCustomerXRef:110]customerID:2:=[OrderLine:49]customerID:2
				[MfrCustomerXRef:110]zipCustomer:8:=[Order:3]zip:20
				[MfrCustomerXRef:110]customerName:6:=[Order:3]company:15
				[MfrCustomerXRef:110]dateLastUpdate:7:=Current date:C33
				[MfrCustomerXRef:110]mfrid:3:=[OrderLine:49]mfrid:52
				If ([Customer:2]customerID:1#[OrderLine:49]customerID:2)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[OrderLine:49]customerID:2)
					If ([Customer:2]publish:91>0)
						[MfrCustomerXRef:110]publishStatus:11:="Publish Level"+String:C10([Customer:2]publish:91)
					Else 
						[MfrCustomerXRef:110]publishStatus:11:="Dealer Not Published"
					End if 
				End if 
				$w:=Find in array:C230(<>aMfg; [OrderLine:49]mfrid:52)
				If ($w>0)
					[MfrCustomerXRef:110]manufacturerName:5:=<>aMfgName{$w}
				End if 
			Else 
				[MfrCustomerXRef:110]value:4:=[MfrCustomerXRef:110]value:4+[OrderLine:49]extendedPrice:11
			End if 
			SAVE RECORD:C53([MfrCustomerXRef:110])
			NEXT RECORD:C51([OrderLine:49])
		End for 
		//Thermo_Close 
		Progress QUIT($viProgressID)
	End if 
Else 
	CONFIRM:C162("Rebuild Items Carried by Zip  for [OrderLine]: "+String:C10($k))
	If (OK=1)
		$doItemZip:=True:C214
		CONFIRM:C162("Delete Existing [ItemsCarried] records")
		If (OK=1)
			$doItemZipDelete:=True:C214
		End if 
	End if 
	If (($doItemZip) | ($doMfrs))
		OrdLn_Update
	End if 
	If ($doItemZip)
		//ThermoInitExit ("ItemsCarried Information";$k;True)
		$viProgressID:=Progress New
		
		If ($doItemZipDelete)
			ALL RECORDS:C47([ItemCarried:113])
			DELETE SELECTION:C66([ItemCarried:113])
		End if 
		ORDER BY:C49([OrderLine:49]; [OrderLine:49]itemNum:4; [OrderLine:49]customerID:2; [OrderLine:49]orderNum:1)
		FIRST RECORD:C50([OrderLine:49])
		For ($i; 1; $k)
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "ItemsCarried Information")
			If (ThermoAbort)
				$i:=$k
			End if 
			If ([OrderLine:49]orderNum:1#[Order:3]orderNum:2)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
			End if 
			QUERY:C277([ItemCarried:113]; [ItemCarried:113]itemNum:2=[OrderLine:49]itemNum:4; *)
			//QUERY([ItemsCarried];&[ItemsCarried]mfrID=[OrderLine]mfrID;*)//managed by item number
			QUERY:C277([ItemCarried:113];  & [ItemCarried:113]customerID:6=[OrderLine:49]customerID:2; *)
			QUERY:C277([ItemCarried:113];  & [ItemCarried:113]zipCustomer:8=[Order:3]zip:20)
			If (Records in selection:C76([ItemCarried:113])=0)
				CREATE RECORD:C68([ItemCarried:113])
				
				[ItemCarried:113]mfrid:4:=[OrderLine:49]mfrid:52
				$w:=Find in array:C230(<>aMfg; [OrderLine:49]mfrid:52)
				If ($w>0)
					[ItemCarried:113]manufacturerName:9:=<>aMfgName{$w}
				End if 
				[ItemCarried:113]itemNum:2:=[OrderLine:49]itemNum:4
				[ItemCarried:113]description:3:=[OrderLine:49]description:5
				[ItemCarried:113]customerID:6:=[OrderLine:49]customerID:2
				[ItemCarried:113]zipCustomer:8:=[Order:3]zip:20
				[ItemCarried:113]customerName:7:=[Order:3]company:15
				If ([Customer:2]customerID:1#[OrderLine:49]customerID:2)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[OrderLine:49]customerID:2)
					If ([Customer:2]publish:91>0)
						[ItemCarried:113]publishStatus:11:="Publish Level "+String:C10([Customer:2]publish:91)
					Else 
						[ItemCarried:113]publishStatus:11:="Dealer Not Published"
					End if 
				End if 
			End if 
			[ItemCarried:113]value:5:=[ItemCarried:113]value:5+[OrderLine:49]extendedPrice:11
			SAVE RECORD:C53([ItemCarried:113])
			NEXT RECORD:C51([OrderLine:49])
		End for 
		//Thermo_Close 
		Progress QUIT($viProgressID)
	End if 
End if 

If (False:C215)
	READ WRITE:C146([MfrCustomerXRef:110])
	vi2:=Records in selection:C76([MfrCustomerXRef:110])
	FIRST RECORD:C50([MfrCustomerXRef:110])
	For (vi1; 1; vi2)
		vi3:=Find in array:C230(<>aMfg; [MfrCustomerXRef:110]mfrid:3)
		If (vi3>0)
			[MfrCustomerXRef:110]manufacturerName:5:=<>aMfgName{vi3}
			SAVE RECORD:C53([MfrCustomerXRef:110])
		End if 
		NEXT RECORD:C51([MfrCustomerXRef:110])
	End for 
End if 
