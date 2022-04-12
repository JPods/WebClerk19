//%attributes = {"publishedWeb":true}
//Procedure: Http_PostGen
If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 


C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_TEXT:C284($4; $suffix)
//February 11, 2002, Added [Service]Publish
//
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$suffix:=""
//
If ([EventLog:75]remoteUserRec:10>-1)
	$strDate:=WCapi_GetParameter("ActionDate"; "")
	CREATE RECORD:C68($3->)
	WC_Parse(Table:C252($3); $2)
	//
	Case of 
		: ($4="Forum")
			[Forum:80]dtSubmitted:6:=DateTime_Enter
			[Forum:80]publish:7:=1
			[Forum:80]dateEntered:9:=Current date:C33
			[Forum:80]timeEntered:10:=Current time:C178
		: ($4="Serv")
			If ([Service:6]attention:30="")
				[Service:6]attention:30:=[RemoteUser:57]name:20
			End if 
			If ([Service:6]actionCreatedBy:40="")
				[Service:6]actionCreatedBy:40:=[RemoteUser:57]userName:2
			End if 
			Case of 
				: ([Service:6]customerID:1="public")
				: (Record number:C243([Customer:2])>-1)
					[Service:6]customerID:1:=[Customer:2]customerID:1
				Else 
					[Service:6]customerID:1:="GDwebClerk"
					[Service:6]company:48:=[Customer:2]company:2
			End case 
			[Service:6]dtDocument:16:=DateTime_Enter
			[Service:6]dtBegin:15:=[Service:6]dtDocument:16
			Case of 
				: ([Service:6]noteType:21="Reservation")
					READ WRITE:C146([Reservation:79])
					QUERY:C277([Reservation:79]; [Reservation:79]idNum:16=Num:C11([Service:6]reference:37))
					If (Records in selection:C76([Reservation:79])=1)
						[Reservation:79]status:20:=[Service:6]action:20
						[Reservation:79]dtAction:19:=[Service:6]dtDocument:16
						[Reservation:79]publicNote:11:=$userInfo+("\r"*Num:C11([Service:6]comment:11#""))+[Service:6]comment:11+"\r"+[Reservation:79]publicNote:11
						[Reservation:79]privateNote:12:=$privateInfo+"\r"+[Reservation:79]privateNote:12
						SAVE RECORD:C53([Reservation:79])
					End if 
					REDUCE SELECTION:C351([Reservation:79]; 0)
					READ ONLY:C145([Reservation:79])
				: ([Service:6]noteType:21="")
					[Service:6]noteType:21:="NetPost"
			End case 
		: ($4="Call")
			GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
			If (([EventLog:75]tableNum:9=(Table:C252(->[Rep:8]))) | ([EventLog:75]tableNum:9=(Table:C252(->[Employee:19]))))
				[CallReport:34]tableNum:2:=[EventLog:75]tableNum:9
				If ([EventLog:75]tableNum:9=(Table:C252(->[Rep:8])))
					GOTO RECORD:C242([Rep:8]; [EventLog:75]customerRecNum:8)
					[CallReport:34]customerID:1:=[Rep:8]RepID:1
				Else 
					GOTO RECORD:C242([Employee:19]; [EventLog:75]customerRecNum:8)
					[CallReport:34]actionBy:3:=[Employee:19]nameID:1
				End if 
				[CallReport:34]dateDocument:17:=Current date:C33
				[CallReport:34]dtAction:4:=DateTime_Enter(Date:C102($strDate))
			End if 
			
			
	End case 
	
	SAVE RECORD:C53($3->)
	//
	
	
End if 
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
Case of 
	: ([EventLog:75]remoteUserRec:10=-1)
		vResponse:="You are not registered or you have not signed in yet."
	: ($jitPageOne#"")
		$doPage:=WC_DoPage($jitPageOne; "")
	: ($4="Forum")
		$doPage:=WC_DoPage("ForumRec"+$suffix+".html"; "")
	: ($4="Serv")
		//TRACE
		$doPage:=WC_DoPage("ServiceRec"+$suffix+".html"; "")
	: ($4="Call")
		TRACE:C157
		$doPage:=WC_DoPage("CallRec"+$suffix+".html"; "")
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)
