//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 12:43:32
// ----------------------------------------------------
// Method: PopDownLoadMessage
// Description
// 
//
// Parameters

//pop3_ID       Longint              Reference to a POP3 login
//msgNumber       Longint              Message number
//headerOnly       Integer              0 = Entire message, 1 = Only header
//fileName       Text              Local Filename
//                     Resulting Local Filename
//Function result       Integer              Error Code
// ----------------------------------------------------



C_LONGINT:C283($1; $pop3_ID; $2; $msgNumber)
C_LONGINT:C283($headerOnly)
C_TEXT:C284($fileName)





$pop3_ID:=$1
$msgNumber:=$2
$headerOnly:=0

$error:=POP3_Download($pop3_ID; $msgNumber; $headerOnly; $fileName)


