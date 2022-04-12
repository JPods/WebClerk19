//%attributes = {"publishedWeb":true}
//ALERT("Reserved for future release.")
//If (False)
//Procedure: Tm_SchdSetter
//July 10, 1996

//Method: ScheduleProcess
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Scheduler")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("ScheduleWindowOpen"; <>tcPrsMemory; "Scheduler")
End if 

DELAY PROCESS:C323(Current process:C322; 30)


If (False:C215)
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
		<>processAlt:=New process:C317("Tm_SchdSetOpen"; <>tcPrsMemory; "Schedule Setter")
	End if 
	//End if 
End if 
