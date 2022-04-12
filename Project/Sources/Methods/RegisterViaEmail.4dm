//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/15/10, 22:31:29
// ----------------------------------------------------
// Method: RegisterViaEmail
// Description
// 
//
// Parameters
// ----------------------------------------------------
// must submit: email


C_LONGINT:C283($1)
C_POINTER:C301($2)

C_TEXT:C284($jitPageOne)
C_TEXT:C284($userEmail)

vResponse:="Error: Registering by Email."
$doPage:="Register4Error.html"

$userEmail:=WCapi_GetParameter("email"; "")  //  

If ($userEmail="")
	vResponse:="The email address submitted was empty."
Else 
	If (Position:C15(Char:C90(64); $userEmail)<2)
		vResponse:="The email address submitted was not complete."
	Else 
		
		C_LONGINT:C283($i; $k; $cntFoundEmails)
		If (<>viDebugMode>410)
			ConsoleMessage("RegisterViaEmail")
		End if 
		$cntFoundEmails:=EmailQueryAcrossTables($userEmail)
		
		
		If ($cntFoundEmails>0)
			vResponse:=vResponse+"\r"+"This email:  "+$userEmail+" was already registered "+String:C10($cntFoundEmails)+" times."
			$jitPageError:=WCapi_GetParameter("jitPageError"; "")  // page to be displayed at completion of this procedure
			If ($jitPageError="")
				$doPage:="Register4Error.html"
			End if 
			
			CREATE RECORD:C68([TallyResult:73])
			[TallyResult:73]name:1:=$userEmail
			[TallyResult:73]purpose:2:="ErrorEmail"
			[TallyResult:73]dtReport:12:=DateTime_Enter
			[TallyResult:73]dateCreated:53:=Current date:C33
			[TallyResult:73]profile1:17:="open"
			[TallyResult:73]profile2:18:="multiple emails"
			[TallyResult:73]profile3:19:="RegisterViaEmail"
			[TallyResult:73]textBlk1:5:="Sales >> Dept >> Email Query Across Tables  (P) EmailQueryMenu"
			[TallyResult:73]textBlk2:6:=[TallyResult:73]textBlk2:6+"\r"+"\r"+vResponse
			SAVE RECORD:C53([TallyResult:73])
			
			[EventLog:75]status:48:="Duplicate email registration"
			EventLogsMessage("\r"+"Registration: "+$userEmail+": "+vResponse)
			SAVE RECORD:C53([EventLog:75])
		Else 
			vResponse:="An email has been sent to:  "+$userEmail
			[EventLog:75]status:48:="Lock-Pending email"
			EventLogsMessage("\r"+"Registration: "+$userEmail+": "+vResponse)
			[EventLog:75]email:56:=$userEmail
			C_LONGINT:C283($dtCurrent)
			$dtCurrent:=DateTime_Enter
			
			[EventLog:75]dtExpires:55:=$dtCurrent+7200  // start 2 hours
			SAVE RECORD:C53([EventLog:75])
			
			jitPageOne:=""
			
			EmailByTallyMaster($userEmail; "registerrequest"; "WebClerk")
			
			//eMail_Notices ($moreComments)//send copy emails
			If (vResponse="email success@")
				// failed to send email
				// keep error page 
				If (jitPageOne#"")
					$doPage:=jitPageOne
				Else 
					$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")  // page to be displayed at completion of this procedure
					If ($jitPageOne="")
						$doPage:="Register2EmailSent.html"  // Notice that email has been sent
					Else 
						$doPage:=$jitPageOne
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)


