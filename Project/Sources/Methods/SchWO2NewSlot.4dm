//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/21/06, 17:15:57
// ----------------------------------------------------
// Method: SchWO2NewSlot
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
C_LONGINT:C283($2; $3; $4; $5; $6; $9)
C_DATE:C307($7)
C_TIME:C306($8)
$theError:=0
If ($1="name ID@")
	$theError:=1
End if 
If (($2=0) | ($3=0) | ($4=0) | ($5=0) | ($6=0))
	$theError:=1
End if 
If ($7=!00-00-00!)  //Date
	$theError:=$theError+1
End if 
If ($theError>0)
	ALERT:C41("No employee, no date or missing data.")
Else 
	CONFIRM:C162("Move WorkOrder?")
	If (OK=1)
		$woRecNum:=$9
		//If (False)
		If ($woRecNum>0)
			GOTO RECORD:C242([WorkOrder:66]; $woRecNum)
			[WorkOrder:66]actionBy:8:=$1
			[WorkOrder:66]dtAction:5:=DateTime_Enter($7; $8)
			SAVE RECORD:C53([WorkOrder:66])
		End if 
		Sched_Reset($2)
	End if 
End if 