//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/26/20, 12:56:29
// ----------------------------------------------------
// Method: DebugMessage
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtMessage)
$vtMessage:=$1

C_LONGINT:C283($viMinDebugLevel)
If (Count parameters:C259>=2)
	$viMinDebugLevel:=$2
Else 
	$viMinDebugLevel:=410
End if 

If (<>viDebugMode>=$viMinDebugLevel)
	ConsoleMessage($vtMessage)
End if 