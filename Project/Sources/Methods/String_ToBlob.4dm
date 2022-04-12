//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 05/28/20, 16:15:53
// ----------------------------------------------------
// Method: String_ToBlob
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BLOB:C604($0; $vblBlob)
SET BLOB SIZE:C606($vblBlob; 0)

C_TEXT:C284($1; $vtText)
$vtText:=$1

TEXT TO BLOB:C554($vtText; $vblBlob; UTF8 text without length:K22:17; *)

$0:=$vblBlob