//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/12/18, 16:28:55
// ----------------------------------------------------
// Method: WATextIntoArea
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptwebArea)
C_TEXT:C284($2; $tinyMCEContent; $3; $doTiny)

$ptwebArea:=$1
$tinyMCEContent:=$2
If (Count parameters:C259>2)
	$doTiny:=$3
End if 



If (($doTiny="tiny@") | ($doTiny="mce@") | ($doTiny="edit@"))
	
	C_TEXT:C284($wa_htmlEditor_path_t)
	$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"emaileditor.html"  // ### jwm ### 20181017_1610
	$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
	WA OPEN URL:C1020($ptwebArea->; "file:///"+$wa_htmlEditor_path_t)
	
	DELAY PROCESS:C323(Current process:C322; 12)
	
	// see $2 above
	WA EXECUTE JAVASCRIPT FUNCTION:C1043($ptwebArea->; "setContent"; *; $tinyMCEContent)  //  tinyMCE_cleanCR ($tinyMCEContent))
	
	//WA EXECUTE JAVASCRIPT FUNCTION($ptwebArea->;"resize";*;"600";"200") 
	
	
	// * returns no result
	//c WA SET PAGE CONTENT($ptwebArea->;$tinyMCEContent;"file:///")
	
	
	
Else 
	WA SET PAGE CONTENT:C1037($ptwebArea->; $tinyMCEContent; "file:///")
End if 
