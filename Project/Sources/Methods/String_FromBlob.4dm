//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 05/28/20, 16:15:53
// ----------------------------------------------------
// Method: String_FromBlob
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $vtText)
$vtText:=""

C_BLOB:C604($1; $vblBlob)
$vblBlob:=$1

$vtText:=BLOB to text:C555($vblBlob; UTF8 text without length:K22:17)

$0:=$vtText