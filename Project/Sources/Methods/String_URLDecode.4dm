//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/06/19, 09:00:12
// ----------------------------------------------------
// Method: String_URL_Encode
// Description
// 
//
// Parameters
// ----------------------------------------------------

// SET UP VARIABLES

C_TEXT:C284($0; $vtURLDecoded)

C_TEXT:C284($1; $vtURLToDecode)
$vtURLToDecode:=$1

// USE PHP'S BUILT IN URL ENCODE FUNCTION

vbOK:=PHP Execute:C1058(""; "urldecode"; $vtURLDecoded; $vtURLToDecode)

If (<>viDebugMode>410)
	ConsoleLog("$vtURLToDecode\t"+$vtURLToDecode)
	ConsoleLog("$vtURLDecoded\t"+$vtURLDecoded)
End if 

// RETURN ENCODED URL

$0:=$vtURLDecoded
