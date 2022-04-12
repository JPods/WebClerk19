//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 13:34:14
// ----------------------------------------------------
// Method: PopDeleteMessage
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($pop3_ID; $1; $startMsg; $2; $endMsg; $3)
$pop3_ID:=$1
$startMsg:=$2
$endMsg:=$3
//
$error:=POP3_Delete($pop3_ID; $startMsg; $endMsg)
