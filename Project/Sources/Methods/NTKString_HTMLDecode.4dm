//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 08:56:35
// ----------------------------------------------------
// Method: NTKString_HTMLDecode
// Description
// 
//
// Parameters
// ----------------------------------------------------
// (PM) String_HTMLDecode
// Decodes HTML entities in a text
// $1 = HTML Encoded text (in ISO encoding)
// $0 = Decoded text

// (PM) String_HTMLDecode
// Decodes HTML entities in a text
// $1 = HTML Encoded text (in ISO encoding)
// $0 = Decoded text

C_TEXT:C284($1; $0; $input; $output; $pattern)

$input:=$1

// Initialize our array with HTML entities
//NTKString__InitHTMLEntities 

// Replace the HTML entities using a regular expression and a callback method
$pattern:="&#?(\\w+);"
$output:=Preg Replace Callback($pattern; "NTKString__HTMLDecodeCallback"; $input)

$0:=$output