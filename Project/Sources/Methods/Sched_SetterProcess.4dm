//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/12/06, 08:02:48
// ----------------------------------------------------
// Method: Sched_SetterProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------
KeyModifierCurrent
C_DATE:C307(clickDate)
If (clickDate=!00-00-00!)
	clickDate:=Current date:C33
End if 
//If (OptKey=0)
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Schedule Setter")
//
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	$processAlt:=New process:C317("Tm_SchdSetOpen"; <>tcPrsMemory; "Schedule Setter"; clickDate)
End if 
//Else 
//<>ptCurTable:=ptCurTable
//<>prcControl:=1
//$processAlt:=New process("Tm_SchdSetOpen";<>tcPrsMemory;"Schedule Setter"+String(Count tasks+1);clickDate)
//
//End if 