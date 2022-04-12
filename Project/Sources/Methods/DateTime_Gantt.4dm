//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/02/21, 23:04:15
// ----------------------------------------------------
// Method: DateTime_Gantt
// Description
// 
//
// Parameters
// ----------------------------------------------------


#DECLARE($vdDate : Date; $vtTime : Time)->$vtResult : Text
If (Count parameters:C259<2)
	$vtTime:=Current time:C178
	If (Count parameters:C259<1)
		$vdDate:=Current date:C33
	End if 
End if 

$vtResult:=String:C10(Year of:C25($vdDate); "0000")+"-"+String:C10(Month of:C24($vdDate); "00")+"-"+String:C10(Day of:C23($vdDate); "00")+" "+String:C10($vtTime; HH MM:K7:2)