
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-27T00:00:00, 00:00:57
// ----------------------------------------------------
// Method: [Customer].Input1.Button4
// Description
// Modified: 06/27/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($thePath)

// ### bj ### 20181202_0058
//  discovered very long instability in sending emails 
// the variable were named the same as the fields
// the program was confusing them with each other some times.
vtEmailSubject:="WebClerk email test "+String:C10(Current date:C33)
vtEmailBody:="My name is: "+[Employee:19]nameFirst:3+" "+[Employee:19]nameLast:2
vtEmailSender:=[Employee:19]email:16
vtEmailPassword:=[Employee:19]emailPassword:61
vtEmailSenderID:=[Employee:19]nameFirst:3+" "+[Employee:19]nameLast:2
vtEmailPath:=""
vtEmailReceiver:=[Employee:19]email:16
viEmailport:=[Employee:19]emailPortOut:59
vtEmailServer:=[Employee:19]emailServerOut:58
vtEmailUserName:=[Employee:19]emailUserName:60

// SMTP_Email 
C_LONGINT:C283($myDebug)
$myDebug:=<>viDebugMode
<>viDebugMode:=411
SMTP_SendMsg
<>viDebugMode:=$myDebug