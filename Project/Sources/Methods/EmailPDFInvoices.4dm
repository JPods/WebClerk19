//%attributes = {}

//Script Email PDF Invoice 20190709

Process_InitLocal  // ### jwm ### 20190703_1533 declare all local variables

QUERY:C277([RemoteUser:57]; [RemoteUser:57]keyTags:15="pdf Email password@"; *)
//Query([RemoteUser];&;[RemoteUser]Key="customerID";*)
QUERY:C277([RemoteUser:57])

ORDER BY:C49([RemoteUser:57]; [RemoteUser:57]company:16; >)

vi2:=Records in selection:C76([RemoteUser:57])

FIRST RECORD:C50([RemoteUser:57])


$viProgressID:=Progress New


For (vi1; 1; vi2)
	
	ProgressUpdate($viProgressID; vi1; vi2; "Sending PDF Invoices...")
	
	QUERY:C277([Invoice:26]; [Invoice:26]dateShipped:4<=(Current date:C33-1); *)
	
	Case of 
			
		: ([RemoteUser:57]key:21="customerID")
			
			QUERY:C277([Invoice:26];  & ; [Invoice:26]customerID:3=[RemoteUser:57]userName:2; *)
			
		: ([RemoteUser:57]key:21="TypeSale")
			
			QUERY:C277([Invoice:26];  & ; [Invoice:26]typeSale:49=("@"+[RemoteUser:57]userName:2+"@"); *)
			
		: ([RemoteUser:57]key:21="AdSource")
			
			QUERY:C277([Invoice:26];  & ; [Invoice:26]adSource:52=[RemoteUser:57]userName:2; *)
			
	End case 
	
	QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)  //     Not Void
	QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)  //  Not Error
	QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@PDF@"; *)  //  Not already sent PDF
	QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@CM1@"; *)  //  Not Commission under Review
	QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@CR1@"; *)  //  Not Credit under Review
	QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@PRN@"; *)  //  Not already sent as PRN
	QUERY:C277([Invoice:26])
	
	vi3:=Records in selection:C76([Invoice:26])
	If ((vi3>0))
		ConsoleMessage("\r"+String:C10(vi3)+" "+[RemoteUser:57]name:20+" Invoices ")
		vHere:=0  // called from Script
		ptCurTable:=->[Invoice:26]
		QUERY:C277([UserReport:46]; [UserReport:46]name:2="PDF Invoice Export"; *)
		QUERY:C277([UserReport:46])
		vtJobName:=Txt_Clean([RemoteUser:57]name:20)+"_"+DateTime("yyyymmdd_hhmm")
		SRE_Print
		$vtPath:=Storage:C1525.folder.jitDocs+vtJobName+".pdf"
		
		// <>emailEncode
		// atEmailAttachments  // multiple attachments
		// atEmailBCC
		// atEmailCC
		// viEmailSSL
		// vtEmailAttachment  // single arttachments
		// vtEmailBody
		// vtEmailPassword
		// viEmailport
		// vtEmailReceiver
		// vtEmailReplyTo
		// vtEmailReport
		// vtEmailSender
		// vtEmailServer
		// vtEmailStatusMessage
		// vtEmailSubject
		// vtEmailUserName
		
		
		ARRAY TEXT:C222(atEmailBCC; 0)
		APPEND TO ARRAY:C911(atEmailBCC; "r.brumfiel@functionaldevices.com")
		APPEND TO ARRAY:C911(atEmailBCC; "j.medlen@functionaldevices.com")
		
		<>emailEncode:=2
		vtEmailAttachment:=$vtPath
		
		QUERY:C277([UserReport:46]; [UserReport:46]name:2="Email PDF Invoice"; *)
		QUERY:C277([UserReport:46])
		
		vtEmailBody:=TagsToText([UserReport:46]template:7)
		vtEmailSender:="noreply@functionaldevices.com"
		vtEmailSenderID:="Email"
		vtEmailReplyTo:="sales@functionaldevices.com"
		vtEmailReceiver:=[RemoteUser:57]email:14
		//vtEmailReceiver:="j.medlen@functionaldevices.com; jmedlen@aol.com; j.medlen@comcast.net"
		vtEmailSubject:="PDF Invoices"
		
		ConsoleMessage("Sending email "+vtEmailSubject+" to "+vtEmailReceiver)
		
		//SMTP_Email // contains email_build
		
		SMTP_SentBy(vtEmailSenderID)
		SMTP_SendMsg
		
		UNLOAD RECORD:C212([UserReport:46])
		
		//DELETE DOCUMENT($vtPath)
		
	End if 
	
	NEXT RECORD:C51([RemoteUser:57])
End for 

Progress QUIT($viProgressID)

UNLOAD RECORD:C212([RemoteUser:57])
UNLOAD RECORD:C212([Invoice:26])


