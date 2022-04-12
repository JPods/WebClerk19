//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/15/18, 15:10:21
// ----------------------------------------------------
// Method: WC_LogEvent
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($viLength)
If (voState.log=Null:C1517)
	voState.log:=New collection:C1472
End if 

C_TEXT:C284($1; $procedure; $2; $status)
$procedure:=""
If (Count parameters:C259=1)
	$status:=$1
	voState.log.push(New object:C1471("status"; $status))
Else 
	If (Count parameters:C259>1)
		$procedure:=$1
		$status:=$2
		voState.log.push(New object:C1471($procedure; $status))
	End if 
End if 
