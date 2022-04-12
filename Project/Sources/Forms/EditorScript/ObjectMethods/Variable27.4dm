// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-07-20T00:00:00, 00:53:59
// ----------------------------------------------------
// Method: [Control].SummaryText.Variable26
// Description
// Modified: 07/20/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($textStarting; $textWorked; $jsonParseText)
$textStarting:=vTextSummary
$textWorked:=jsonTextBlockTojason(vTextSummary)

vTextSummary:=$textStarting+(3*"\r")+$textWorked
If (False:C215)
	ARRAY OBJECT:C1221($objArray; 0)
	JSON PARSE ARRAY:C1219($textWorked; $objArray)
	C_TEXT:C284($myMime; $myValue; $returnText)
	
	C_LONGINT:C283($inc; $cnt)
	$cnt:=Size of array:C274($objArray)
	For ($inc; 1; $cnt)
		$mySuffix:=OB Get:C1224($objArray{$inc}; "suffix")
		$myMime:=OB Get:C1224($objArray{$inc}; "mimes")
		$returnText:=$returnText+$mySuffix+"\t"+$myMime+"\r"
	End for 
	
	vTextSummary:=vTextSummary+(3*"\r")+$returnText
	
	
	// jsonParseToArray 
	
	
End if 
