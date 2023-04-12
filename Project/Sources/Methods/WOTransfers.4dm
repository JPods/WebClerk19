//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/09/12, 18:30:06
// ----------------------------------------------------
// Method: WOTransfers
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("WorkOrder Transfer")
If ($found>0)
	BRING TO FRONT:C326($found)
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("WOTransfer_WindowOpen"; <>tcPrsMemory; "WorkOrder Transfer")
End if 

