//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/18, 21:46:42
// ----------------------------------------------------
// Method: PasswordReset
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
C_TEXT:C284(vResponse; $userEmail)
C_POINTER:C301($2)

$userEmail:=WCapi_GetParameter("email"; "")  //  

$doPage:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150916_1006
If ($doPage="")
	$doPage:="Password4Error.html"
End if 
vResponse:="Error: no RemoteUsers found"

C_LONGINT:C283($cntFoundEmails)
If (<>viDebugMode>410)
	ConsoleLog("PasswordReset")
End if 
$cntFoundEmails:=EmailQuery(->[RemoteUser:57]email:14; $userEmail; ->vResponse)
Case of 
	: ($cntFoundEmails=0)
		vResponse:=vResponse+"\r"+"Error: no user found using "+$userEmail
	: ($cntFoundEmails>1)
		vResponse:=vResponse+"\r"+"Error: Multiple listings of "+$userEmail+" and a notice has been sent to the system administrator"
		CREATE RECORD:C68([TallyResult:73])
		[TallyResult:73]name:1:=$userEmail
		[TallyResult:73]purpose:2:="ErrorEmail"
		[TallyResult:73]dtReport:12:=DateTime_DTTo
		[TallyResult:73]dateCreated:53:=Current date:C33
		[TallyResult:73]profile1:17:="open"
		[TallyResult:73]profile2:18:="multiple emails"
		[TallyResult:73]profile3:19:="Password Reset"
		[TallyResult:73]textBlk1:5:="Sales >> Dept >> Email Query Across Tables  (P) EmailQueryMenu"
		[TallyResult:73]textBlk2:6:=[TallyResult:73]textBlk2:6+"\r"+vResponse
		SAVE RECORD:C53([TallyResult:73])
	: ($cntFoundEmails=1)
		vResponse:=vResponse+"\r"+"Email reset password for: "+$userEmail
		$doPage:=WCapi_GetParameter("jitPageOne"; "")  // ### jwm ### 20150916_1006
		If ($doPage="")
			$doPage:="Password2EmailSent.html"
		End if 
		
		[EventLog:75]status:48:="Password Reset Pending"
		EventLogsMessage("\r"+"Password Reset Pending: "+$userEmail)
		[EventLog:75]email:56:=$userEmail
		C_LONGINT:C283($dtCurrent)
		$dtCurrent:=DateTime_DTTo
		
		[EventLog:75]dtExpires:55:=$dtCurrent+7200  // start 2 hours
		SAVE RECORD:C53([EventLog:75])
		
		EmailByTallyMaster($userEmail; "passwordrequest"; "WebClerk")
		
		//eMail_Notices ($moreComments)//send copy emails
		If (vResponse="email success@")
			// failed to send email
			// keep error page 
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")  // page to be displayed at completion of this procedure
			If ($jitPageOne="")
				$doPage:="Password2EmailSent.html"  // Notice that email has been sent
			Else 
				$doPage:=$jitPageOne
			End if 
		End if 
		
End case 

$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)