//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/23/19, 10:28:52
// ----------------------------------------------------
// Method: CronManager
// Description
// 
//
// Parameters
// ----------------------------------------------------


viProcessNum:=Process number:C372("CronManager")
//TRACE
If (viProcessNum=0)
	<>CronProcess:=New process:C317("Prs_CronManager"; <>tcPrsMemory; "CronManager")
End if 

While (viProcessNum=0)
	viProcessNum:=Process number:C372("CronManager")
End while 


If ((Macintosh option down:C545) | (Windows Alt down:C563))
	CONFIRM:C162("Show CronManager"; "Show"; "Hide")
	
	If (OK=1)
		vbShow:=True:C214
	Else 
		vbShow:=False:C215
	End if 
	
	SET PROCESS VARIABLE:C370(viProcessNum; vbShow; vbShow)
	If (vbShow)
		SHOW PROCESS:C325(viProcessNum)
		POST OUTSIDE CALL:C329(viProcessNum)
	Else 
		HIDE PROCESS:C324(viProcessNum)
	End if 
End if 
