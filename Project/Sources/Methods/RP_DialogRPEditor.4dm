//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/21/06, 15:59:17
// ----------------------------------------------------
// Method: RP_DialogRPEditor
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Record Passing")
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("RP_WindowOpen"; <>tcPrsMemory; "Record Passing")
End if 



