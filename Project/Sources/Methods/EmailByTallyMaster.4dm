//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/18, 11:18:44
// ----------------------------------------------------
// Method: EmailByTallyMaster
// Description
// EmailByTallyMaster
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; vtEmailReceiver; $2; $name; $3; $purpose; $4; $alttext)
vtEmailReceiver:=$1
$name:=$2
$purpose:=$3


READ ONLY:C145([TallyMaster:60])
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$name; *)  //"WebClerk_NewOrder""
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]publish:25>0; *)  //"WebClerk_NewOrder""
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]purpose:3=$purpose)
vtEmailPath:=""
If (Records in selection:C76([TallyMaster:60])=0)
	C_TEXT:C284(HTTP_Protocol)
	If (TCP Is Secure Connection(voState.socket)=1)
		HTTP_Protocol:="https"
	Else 
		HTTP_Protocol:="http"
	End if 
	Case of 
		: ($name="passwordrequest")
			vtEmailPath:=""
			vtEmailSubject:="Reset Password Request: "+Storage:C1525.default.domain
			vtEmailBody:="<html><body><Resetting your password.  <br /><br />Please click on the following link to reset password. It is only valid for two hours.<br /><br />"+"\r"+"\r"
			vtEmailBody:=vtEmailBody+"<a href="+Txt_Quoted(HTTP_Protocol+"://"+Storage:C1525.default.domain+"/Password_Verified?email="+vtEmailReceiver+"&code="+[EventLog:75]id:54)+">Reset Password</a></body></html>"
		: ($name="passwordconfirmed")
			vtEmailSubject:="Password Changed: "+Storage:C1525.default.domain
			vtEmailBody:="<html><body><Your password has been rest.  <br /><br />If this was not your intent, please contact us.<br /><br />"+"\r"+"\r"
			vtEmailBody:=vtEmailBody+"<a href="+Txt_Quoted(HTTP_Protocol+"://"+Storage:C1525.default.domain)+">"+Storage:C1525.default.domain+"</a></body></html>"
			vtEmailPath:=""
		: ($name="registerrequest@")
			vtEmailSubject:="Registration Request "+Storage:C1525.default.domain
			vtEmailBody:="<html><body>Thank you for requesting registration.  <br /><br />Please"+" click on the following link to register. It is only valid for two hours.<br /><br />"+"\r"+"\r"
			vtEmailBody:=vtEmailBody+"<a href="+Txt_Quoted(HTTP_Protocol+"://"+Storage:C1525.default.domain+"/Register_Verified?email="+vtEmailReceiver+"&code="+[EventLog:75]id:54)+">Request Registration</a></body></html>"
			vtEmailPath:=""
		: ($name="registerconfirm@")
			vtEmailSubject:="Registration Confirmed "+Storage:C1525.default.domain
			vtEmailBody:="<html><body><Your registration is complete.  <br /><br />If this was not your intent, please contact us.<br /><br />"+"\r"+"\r"
			vtEmailBody:=vtEmailBody+"<a href="+Txt_Quoted(HTTP_Protocol+"://"+Storage:C1525.default.domain)+">"+Storage:C1525.default.domain+"</a></body></html>"
			vtEmailPath:=""
		Else 
			
			// vtEmailSubject:="Password Changed"  must be set by the caller
			// vtEmailBody:=$alttext  must be set by the caller
	End case 
Else 
	vtEmailBody:=[TallyMaster:60]template:29
	If ([TallyMaster:60]script:9#"")
		ExecuteText(0; [TallyMaster:60]script:9)
	End if   //TallyMaster will be released in the execute of script
	//  vtEmailBody:=[TallyMaster]Build
	vtEmailBody:=TagsToText(vtEmailBody)
End if 
REDUCE SELECTION:C351([TallyMaster:60]; 0)
READ WRITE:C146([TallyMaster:60])

If (vtEmailReceiver#"")  // use tallymaster to set "" if you do not want to send an email
	
	SMTP_SentBy("admin"; Current user:C182)
	
	SMTP_SendMsg  //primary send
	
End if 