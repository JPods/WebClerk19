//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/11/11, 09:11:19
// ----------------------------------------------------
// Method: Method: emailVerify
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2)
C_POINTER:C301($3)
<>viDeBugMode:=1

If (<>consoleprocess=0)
	ConsoleMessage("Launch")
End if 

returnEmailAction:=1
vtEmailBody:="test"
vtEmailSubject:="Confirm"
vtEmailPath:=""
vtEmailSender:=""
vtEmailReceiver:=$1
vtEmailReceiver_Tag:=$2+" <"+vtEmailReceiver+">"
EmailVerifyWithTelnet($3; $1)
//
vtEmailMessage:=""
vtEmailMessageLog:=""
vtEmailServer:=""
viEmailport:=0
vtEmailUserName:=""
vtEmailPassword:=""
vtEmailSender:=""
vtEmailReceiver:=""
vtEmailSubject:=""
vtEmailBody:=""
vtEmailPath:=""
vtEmailReport:=""
returnEmailAction:=0