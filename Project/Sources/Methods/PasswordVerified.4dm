//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/18, 23:38:07
// ----------------------------------------------------
// Method: PasswordVerified
// Description
// 
//
// Parameters
// ----------------------------------------------------


// align with RegisterVerified
// should rewrite so one procedure handles both cases
C_LONGINT:C283($1; $err; $remoteHost; $i; $eMailPass)
C_POINTER:C301($2)
$doPage:="Password4Error.html"
$userEmail:=WCapi_GetParameter("email"; "")
$code:=WCapi_GetParameter("code"; "")
C_LONGINT:C283($dtCurrent)
$dtCurrent:=DateTime_DTTo
If (([EventLog:75]id:54=$code) & ([EventLog:75]email:56=$userEmail))
	// found by cookie on the same machine
Else 
	C_LONGINT:C283($viAbandoned)
	$viAbandoned:=obEventLog.id
	WC_LogEvent("Querying for password and UUID: "+$code+": "+$userEmail)
	[EventLog:75]dateComplete:45:=Current date:C33  // close, wakeup if not found
	SAVE RECORD:C53([EventLog:75])
	QUERY:C277([EventLog:75]; [EventLog:75]id:54=$code; *)
	QUERY:C277([EventLog:75];  & ; [EventLog:75]email:56=$userEmail)
End if 
If (Records in selection:C76([EventLog:75])=1)
	WC_LogEvent("Varifying password and UUID: "+$code+": "+$userEmail)
	vleventID:=[EventLog:75]id:54
	
	If ([EventLog:75]dtExpires:55<$dtCurrent)
		vResponse:="Password period expired in 2 hours. Current server time: "+String:C10(Current time:C178)+". Resubmit email: "+$userEmail
		[EventLog:75]status:48:="timedout-emailVerified"
	Else 
		[EventLog:75]status:48:="emailvalidated"
		vResponse:="Valid code. Complete password change within 2 hours."
		[EventLog:75]dtExpires:55:=$dtCurrent+7200
		$doPage:=WCapi_GetParameter("jitPageOne"; "")
		If ($doPage="")  // page only changes if everything passes
			$doPage:="Password3Data.html"  // form to fill out
		End if 
	End if 
Else 
	QUERY:C277([EventLog:75]; [EventLog:75]idNum:5=$viAbandoned)
	[EventLog:75]dateComplete:45:=!00-00-00!  // close, wakeup if not found
	WC_LogEvent("Failed to find EventLogs password and UUID: "+$code+": "+$userEmail)
	vResponse:="id mismatch: "+$userEmail
	[EventLog:75]status:48:=vResponse
End if 

// add the path to the page
SAVE RECORD:C53([EventLog:75])
// send the page
If (<>videbugmode=311)
	ConsoleLog(vResponse)
End if 

$doPage:=WC_DoPage($doPage; "")
$err:=WC_PageSendWithTags($1; $doPage; 0)
