
$selectedItem:=Self:C308->
C_LONGINT:C283($selectedItem)

Case of 
	: ([Customer:2]mfrLocationid:67>-1000)
		ALERT:C41("Not assigned as a Manufacturer")
	: ($selectedItem=0)  //skip
		Self:C308->:=1
	: (aiLoPopCustMfr{$selectedItem}="Manufacturer Records")  //skip
		KeyModifierCurrent
		QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
		If (Records in selection:C76([ManufacturerTerm:111])=0)
			CREATE RECORD:C68([ManufacturerTerm:111])
			[ManufacturerTerm:111]customerID:1:=[Customer:2]customerID:1
			[ManufacturerTerm:111]company:9:=[Customer:2]company:2
			[ManufacturerTerm:111]active:3:=True:C214
			[ManufacturerTerm:111]locationid:2:=[Customer:2]mfrLocationid:67
			SAVE RECORD:C53([ManufacturerTerm:111])
		End if 
		//If (Optkey=1)
		DB_ShowCurrentSelection(->[ManufacturerTerm:111])
		
		vText1:="Query([Item];[Item]ItemNum="+Txt_Quoted("Com"+[Customer:2]customerID:1+"@")+")"+"\r"
		DB_ShowCurrentSelection(->[Item:4]; vText1; 11; ""; 1)
		//
		vText1:="Query([Vendor];[Vendor]VendorID="+Txt_Quoted([Customer:2]customerID:1)+")"+"\r"
		DB_ShowCurrentSelection(->[Vendor:38]; vText1; 11; ""; 1)
		//
		vText1:="Query([RemoteUser];[RemoteUser]TableNum=111;*)"+"\r"
		vText1:=vText1+"Query([RemoteUser]; | [RemoteUser]TableNum=2;*)"+"\r"
		vText1:=vText1+"Query([RemoteUser];&[RemoteUser]customerID="+Txt_Quoted([Customer:2]customerID:1)+")"+"\r"
		DB_ShowCurrentSelection(->[RemoteUser:57]; vText1; 11; ""; 1)
		
		
		//End if 
		C_LONGINT:C283($securityLevel)
		Case of 
			: (Storage:C1525.user.securityLevel>$securityLevel)
				$securityLevel:=Storage:C1525.user.securityLevel
			: (allowAlerts_boo)
				$securityLevel:=Storage:C1525.user.securityLevel
			: (viEndUserSecurityLevel=0)
				$securityLevel:=1
			Else 
				$securityLevel:=viEndUserSecurityLevel
		End case 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=111; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="iLoScripts"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=$securityLevel)
		If (Records in selection:C76([ManufacturerTerm:111])=0)
			DB_ShowCurrentSelection(->[TallyMaster:60])
		End if 
		
		// : ($selectedItem=2)  //"Show RemoteUsers"
	: (aiLoPopCustMfr{$selectedItem}="Show RemoteUsers")  //skip
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10=[Customer:2]customerID:1; *)
		QUERY:C277([RemoteUser:57];  & [RemoteUser:57]tableNum:9=(Table:C252(->[ManufacturerTerm:111])))
		If (Records in selection:C76([RemoteUser:57])=0)
			RemoteUser_Create(->[Customer:2]; [Customer:2]customerID:1; [Customer:2]zip:8; 1)
			[RemoteUser:57]tableNum:9:=Table:C252(->[ManufacturerTerm:111])
			[RemoteUser:57]securityLevel:4:=2
			SAVE RECORD:C53([RemoteUser:57])
		End if 
		DB_ShowCurrentSelection(->[RemoteUser:57])
		//: ($selectedItem=3)  //"Add RemoteUser"
	: (aiLoPopCustMfr{$selectedItem}="Add RemoteUser")  //skip
		RemoteUser_Create(->[Customer:2]; [Customer:2]customerID:1; [Customer:2]zip:8; 1)
		[RemoteUser:57]tableNum:9:=Table:C252(->[ManufacturerTerm:111])
		[RemoteUser:57]securityLevel:4:=4
		SAVE RECORD:C53([RemoteUser:57])
		DB_ShowCurrentSelection(->[RemoteUser:57])
		//: ($selectedItem=4)  //show mfr itemnums
	: (aiLoPopCustMfr{$selectedItem}="Show Items")  //skip
		QUERY:C277([Item:4]; [Item:4]location:9=[Customer:2]mfrLocationid:67)
		DB_ShowCurrentSelection(->[Item:4])
		//: ($selectedItem=5)  //show commission itemNum
	: (aiLoPopCustMfr{$selectedItem}="Create Master Item")  //skip
		ItemMfrCommission(vPartNum)
		
		// : ($selectedItem=6)  //Manufacturer Stores
	: (aiLoPopCustMfr{$selectedItem}="ManufacturerStores")  //skip
		QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]mfrID:3=[Customer:2]customerID:1)
		DB_ShowCurrentSelection(->[MfrCustomerXRef:110])
		
	: ($selectedItem>6)
		GOTO RECORD:C242([TallyMaster:60]; aiLoPopCustMfrRec{$selectedItem})
		If (Record number:C243([TallyMaster:60])>-1)
			ExecuteText(0; [TallyMaster:60]script:9)  //no confirm
		End if 
		
End case 


If (False:C215)
	vi2:=Records in selection:C76([Customer:2])
	FIRST RECORD:C50([Customer:2])
	For (vi1; 1; vi2)
		QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
		If (Records in selection:C76([ManufacturerTerm:111])=0)
			CREATE RECORD:C68([ManufacturerTerm:111])
			[ManufacturerTerm:111]customerID:1:=[Customer:2]customerID:1
			[ManufacturerTerm:111]active:3:=True:C214
			[ManufacturerTerm:111]locationid:2:=[Customer:2]mfrLocationid:67
			
			SAVE RECORD:C53([ManufacturerTerm:111])
		End if 
		NEXT RECORD:C51([Customer:2])
	End for 
End if 