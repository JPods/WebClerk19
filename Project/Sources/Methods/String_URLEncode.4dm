//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/06/19, 09:00:12
// ----------------------------------------------------
// Method: String_URLEncode
// Description
// 
//
// Parameters
// ----------------------------------------------------

// SET UP VARIABLES

C_TEXT:C284($0; $vtURLEncoded)

C_TEXT:C284($1; $vtURLToEncode)
$vtURLToEncode:=$1

// USE PHP'S BUILT IN URL ENCODE FUNCTION

vbOK:=PHP Execute:C1058(""; "urlencode"; $vtURLEncoded; $vtURLToEncode)

// RETURN ENCODED URL

$0:=$vtURLEncoded