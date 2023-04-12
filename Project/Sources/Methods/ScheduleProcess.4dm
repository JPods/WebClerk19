//%attributes = {"publishedWeb":true}
//Method: ScheduleProcess
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Scheduler")
If ($found>0)
	BRING TO FRONT:C326($found)
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("ScheduleWindowOpen"; <>tcPrsMemory; "Scheduler")
End if 