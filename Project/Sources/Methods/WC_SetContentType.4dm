//%attributes = {}
// (PM) WC_SetContentType
// Sets the content type for the request
// $1 = Content type

C_TEXT:C284($1; $contentType)

$contentType:=$1

WC_SetHeaderOut("Content-Type"; $contentType)
