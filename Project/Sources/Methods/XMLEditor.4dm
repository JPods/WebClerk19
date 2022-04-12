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
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("XMLEditorWindow"; <>tcPrsMemory; "XML Editor")
End if 