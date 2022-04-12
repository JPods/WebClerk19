TRACE:C157
$doServiceOrder:=False:C215
Case of 
		//: ([Proposal]ProposalNum=[Service]PpNum)
		//jAlertMessage (12008)
	: (([Service:6]orderNum:22<10) & ([Service:6]customerID:1=""))
		ALERT:C41("There is not a customer or order assigned to this Service Record.")
	: ([Service:6]orderNum:22<10)
		CONFIRM:C162("Would you like to create an Order to support this Service Record?")
		If (OK=1)
			CREATE RECORD:C68([Order:3])
			bEDI_Pass:=False:C215  //prevents code surrounded by blocking ifs
			myCycle:=3
			NxPvOrders
			bEDI_Pass:=True:C214
			[Order:3]company:15:="Service Request"
			[Order:3]attention:44:=[Service:6]attentionContact:55
			[Order:3]address1:16:=[Service:6]address1:56
			[Order:3]address2:17:=[Service:6]address2:57
			[Order:3]city:18:=[Service:6]city:58
			[Order:3]state:19:=[Service:6]state:59
			[Order:3]zip:20:=[Service:6]zip:60
			[Order:3]country:21:=[Service:6]country:61
			[Order:3]phone:67:=[Service:6]phone:62
			[Order:3]email:82:=[Service:6]email:64
			SAVE RECORD:C53([Order:3])
			[Service:6]orderNum:22:=[Order:3]orderNum:2
			$doServiceOrder:=True:C214
		End if 
	Else 
		$doServiceOrder:=True:C214
End case 
If ($doServiceOrder=True:C214)
	C_LONGINT:C283($theDocID; $theCustomerRec)
	$theDocID:=[Order:3]orderNum:2
	$theCustomerRec:=Record number:C243([Customer:2])
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[Service:6]orderNum:22)
	<>vlRecNum:=Record number:C243([Order:3])
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Customer:2])
	DB_ShowCurrentSelection(->[Order:3]; ""; 1; "")
	READ ONLY:C145([Customer:2])
	GOTO RECORD:C242([Customer:2]; $theCustomerRec)
	READ WRITE:C146([Customer:2])
End if 