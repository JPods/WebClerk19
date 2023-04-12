//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/30/21, 22:08:57
// ----------------------------------------------------
// Method: XMLEditor
// Description
// 
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("XML Editor")
//
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("XMLEditorWindow"; <>tcPrsMemory; "XML Editor")
End if 