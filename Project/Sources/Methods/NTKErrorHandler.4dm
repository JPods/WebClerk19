//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/27/08, 02:46:17
// ----------------------------------------------------
// Method: NTKErrorHandler
//In NTK:  App_NTKErrorHandler
// Description
// 
//
// Parameters
// ----------------------------------------------------
// (PM) App_NTKErrorHandler
// $1 = Socket
// $2 = Error class
// $3 = Error message

C_LONGINT:C283($1; $socket)
C_LONGINT:C283($2; $errorClass)
C_TEXT:C284($3; $errorMessage)

$socket:=voState.socket
$errorClass:=$2
$errorMessage:=$3

NTK Debuglog($errorMessage+"\r\n")

//TRACE
