//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/06/21, 15:57:19
// ----------------------------------------------------
// Method: SalesWebArea
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($cntPara; $viParent)
C_LONGINT:C283($found)
$cntPara:=Count parameters:C259
$found:=Prs_CheckRunnin("SalesCalendar")
If ($found>0)
	BRING TO FRONT:C326($found)
Else 
	If ($cntPara=0)
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("SalesWebArea"; <>tcPrsMemory; "SalesCalendar")
	Else 
		
	End if 
End if 