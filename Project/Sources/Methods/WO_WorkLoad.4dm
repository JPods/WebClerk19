//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 15:20:02
// ----------------------------------------------------
// Method: WO_WorkLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Work Load")
//
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("WO_LoadOpenWin"; <>tcPrsMemory; "Work Load")
End if 