//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 10:11:00
// ----------------------------------------------------
// Method: F_WeekNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_DATE:C307($1)
C_LONGINT:C283($0)

C_DATE:C307($date; $debSemNvlAn)

If (Count parameters:C259=1)
	$date:=$1
Else 
	$date:=Current date:C33(*)
End if 

$debSemNvlAn:=F_StartWeek(F_StartYear($date))

If (Day of:C23($debSemNvlAn)>28) | (Day of:C23($debSemNvlAn)=1)
	$0:=1+(($date-$debSemNvlAn)\7)
Else 
	$0:=($date-$debSemNvlAn)\7
End if 