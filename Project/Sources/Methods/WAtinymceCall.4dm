//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/23/18, 17:28:43
// ----------------------------------------------------
// Method: WAtinymceCall
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $webAreaName; $2; $textDisplay; $3; $pathToTinyMCE)

$webAreaName:=$1
tinyMCE_Content_t:=$2  // needs to be a variable to be executed in the Web Area
//  : (Form event=On End URL Loading)
//  WA EXECUTE JAVASCRIPT FUNCTION(WebTech;"setContent";*;tinyMCE_cleanCR (tinyMCE_Content_t))
If (Count parameters:C259>2)
	$pathToTinyMCE:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+$3
Else 
	$pathToTinyMCE:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
End if 
$pathToTinyMCE:=Convert path system to POSIX:C1106($pathToTinyMCE)
WA OPEN URL:C1020(WebTech; "file:///"+$pathToTinyMCE)