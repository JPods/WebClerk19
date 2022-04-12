//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/14/18, 18:58:01
// ----------------------------------------------------
// Method: pathUtilityDocumentReName
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($myPath)
$myPath:=Select folder:C670("")
If (OK=1)
	ARRAY TEXT:C222($aDocList; 0)
	DOCUMENT LIST:C474($myPath; $aDocList)
End if 