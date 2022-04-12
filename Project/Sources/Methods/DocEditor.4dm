//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: DocEditor
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Document Editor")
//
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("DocEditorWindow"; <>tcPrsMemory; "Document Editor")
End if 