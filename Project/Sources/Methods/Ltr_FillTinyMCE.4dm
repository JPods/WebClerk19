//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/19/21, 14:31:11
// ----------------------------------------------------
// Method: Ltr_FillTinyMCE
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tinyMCE_Content_t)
C_LONGINT:C283($2; $bConvert)
$bConvert:=1
$tinyMCE_Content_t:=tinyMCE_Content_t
If (Count parameters:C259=0)
	$bConvert:=bConvert
	$tinyMCE_Content_t:="-Empty-"
Else 
	$tinyMCE_Content_t:=$1
	If (Count parameters:C259>1)
		$bConvert:=$2
	End if 
End if 

C_TEXT:C284(tinyMCE_Content_t)
If (bConvert=1)
	// getting text from the Letter.body
	//WA EXECUTE JAVASCRIPT FUNCTION(WebTech; "getContent"; $tinyMCE_Content_t)
	$tinyMCE_Content_t:=TagsToText($tinyMCE_Content_t)
End if 
If ($tinyMCE_Content_t="")
	$tinyMCE_Content_t:="-Empty-"
End if 
OBJECT SET ENABLED:C1123(bOK; (bConvert=0))
WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "setContent"; *; tinyMCE_cleanCR($tinyMCE_Content_t))
