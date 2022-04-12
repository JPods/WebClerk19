//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:35:50
// ----------------------------------------------------
// Method: MFG_AssignCode
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Employee"))
	If (allowAlerts_boo)
		If ([Customer:2]mfrLocationid:67>-2000000)
			CONFIRM:C162("Set as a manufacturer?")
			If (OK=1)
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Customer:2]customerID:1)
				If (Records in selection:C76([Vendor:38])=1)
					CONFIRM:C162("There is already a vendor with this ID."; "Make New LocationID"; "Skip")
					If (OK=1)
						MfrIDSet
					End if 
				Else 
					MfrIDSet
					[Customer:2]prospect:17:="Manufacturer"
					SAVE RECORD:C53([Customer:2])
					VendorFromCustomer
					ItemMfrCommission
				End if 
				QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
				If (Records in selection:C76([ManufacturerTerm:111])=0)
					CREATE RECORD:C68([ManufacturerTerm:111])
					
					[ManufacturerTerm:111]customerID:1:=[Customer:2]customerID:1
					[ManufacturerTerm:111]active:3:=True:C214
					[ManufacturerTerm:111]locationid:2:=[Customer:2]mfrLocationid:67
					[ManufacturerTerm:111]openingOrderAmount:5:=2.22
					[ManufacturerTerm:111]reOrderAmount:6:=2.22
					[ManufacturerTerm:111]terms:7:="TBD"
					SAVE RECORD:C53([ManufacturerTerm:111])
				End if 
				CONFIRM:C162("Do you wish to publish this Manufacturer at this time?")
				If (OK=1)
					[Customer:2]publish:91:=1
				End if 
				ProcessTableOpen(Table:C252(->[ManufacturerTerm:111])*-1)
			End if 
		End if 
	Else 
		If ([Customer:2]mfrLocationid:67>-2000000)
			MfrIDSet
		End if 
		[Customer:2]prospect:17:="Manufacturer"
		[Customer:2]publish:91:=1
		SAVE RECORD:C53([Customer:2])
		VendorFromCustomer
		ItemMfrCommission
		QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
		If (Records in selection:C76([ManufacturerTerm:111])=0)
			CREATE RECORD:C68([ManufacturerTerm:111])
			
			[ManufacturerTerm:111]customerID:1:=[Customer:2]customerID:1
			[ManufacturerTerm:111]active:3:=True:C214
			[ManufacturerTerm:111]locationid:2:=[Customer:2]mfrLocationid:67
			[ManufacturerTerm:111]company:9:=[Customer:2]company:2
			SAVE RECORD:C53([ManufacturerTerm:111])
		End if 
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Customer:2]); *)
		QUERY:C277([RemoteUser:57];  | [RemoteUser:57]tableNum:9=111; *)  //Table(->[ManufacturerTerm])
		QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=[Customer:2]customerID:1)
		If (Records in selection:C76([RemoteUser:57])=0)
			If ([Customer:2]email:81#"")
				$userName:=[Customer:2]email:81
			Else 
				$userName:=[Customer:2]customerID:1+Txt_RandomString(5; "a"; "z")
			End if 
			RemoteUser_Create(->[Customer:2]; $userName; [Customer:2]zip:8+Txt_RandomString(3; "a"; "z"); 5)
			[RemoteUser:57]keyTags:15:="Manufacturer"
			[RemoteUser:57]role:25:="Manufacturer"
			SAVE RECORD:C53([RemoteUser:57])
		End if 
		
	End if 
	
	
	If (False:C215)
		vi2:=Records in selection:C76([ManufacturerTerm:111])
		FIRST RECORD:C50([ManufacturerTerm:111])
		For (vi1; 1; vi2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ManufacturerTerm:111]customerID:1)
			[ManufacturerTerm:111]company:9:=[Customer:2]company:2
			SAVE RECORD:C53([ManufacturerTerm:111])
			NEXT RECORD:C51([ManufacturerTerm:111])
		End for 
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([ManufacturerTerm:111])
		
		vi2:=Records in selection:C76([ManufacturerTerm:111])
		FIRST RECORD:C50([ManufacturerTerm:111])
		iLoBoolean1:=allowAlerts_boo
		allowAlerts_boo:=False:C215
		For (vi1; 1; vi2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ManufacturerTerm:111]customerID:1)
			ItemMfrCommission
			NEXT RECORD:C51([ManufacturerTerm:111])
		End for 
		allowAlerts_boo:=iLoBoolean
		UNLOAD RECORD:C212([ManufacturerTerm:111])
		UNLOAD RECORD:C212([Item:4])
		
	End if 
End if 