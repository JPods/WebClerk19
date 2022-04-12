//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-02-11T00:00:00, 22:59:18
// ----------------------------------------------------
// Method: WC_GetContentTypeFor
// Description
// Modified: 02/11/16
// Structure: CEv13_131005

//   // ### bj ### 20200102_1232
//  See: WC_MimeBuild
// See:  WC_JsonMime
// C_OBJECT(<>voMimes)
// $vtMimeReturn:=WccMimeTypeReturn ("buildMime")
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160513_1355 added json content type
// (PM) HTTPD_GetContentTypeFor
// Returns the content-type for a given file or extension
// $1 = Filename or extension
// $0 = Content-type

C_TEXT:C284($0; $1; $pathName; $extension; $contentType)
C_LONGINT:C283($w)
// ### bj ### 20181101_1503
//always return something
$0:="text/xml"  //  "application/binary"
If (Count parameters:C259>0)
	$pathName:=$1
Else 
	$pathName:=""
End if 
If (Position:C15("."; $pathName)>0)
	$extension:=SuffixGet($pathName)
Else 
	$extension:=$1
End if 
$w:=Find in array:C230(<>aExtensionValue; $extension)
If ($w>0)
	$contentType:=<>aContentType{$w}
Else 
	ConsoleMessage("Missing ContentType: "+$extension)
	$contentType:="application/json"
End if 
$0:=$contentType
