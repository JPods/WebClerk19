TRACE:C157
Case of 
		//: ([Proposal]ProposalNum=[Service]PpNum)
		//jAlertMessage (12008)
	: ([Service:6]proposalNum:27<10)
		ALERT:C41("No Proposal for this Service Record")
	Else 
		C_LONGINT:C283($theDocID; $theCustomerRec)
		$theDocID:=[Service:6]proposalNum:27
		$theCustomerRec:=Record number:C243([Customer:2])
		QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=[Service:6]proposalNum:27)
		<>ptCurTable:=(->[Proposal:42])
		<>vlRecNum:=Record number:C243([Proposal:42])
		UNLOAD RECORD:C212([Proposal:42])
		UNLOAD RECORD:C212([Customer:2])
		
		DB_ShowCurrentSelection(->[Proposal:42]; ""; 1; "")
		
		DELAY PROCESS:C323(Current process:C322; 180)
		READ ONLY:C145([Customer:2])
		GOTO RECORD:C242([Customer:2]; $theCustomerRec)
		READ WRITE:C146([Customer:2])
End case 