TRACE:C157
Case of 
		//: ([Proposal]ProposalNum=[Service]PpNum)
		//jAlertMessage (12008)
	: ([Service:6]contactID:52<=0)
		ALERT:C41("No Contact for this Service Record")
	Else 
		C_LONGINT:C283($theDocID; $theCustomerRec)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Service:6]contactID:52)
		<>ptCurTable:=(->[Contact:13])
		<>vlRecNum:=Record number:C243([Contact:13])
		UNLOAD RECORD:C212([Contact:13])
		DB_ShowCurrentSelection(->[Contact:13]; ""; 1; "")
End case 