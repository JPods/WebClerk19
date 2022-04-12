//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 10:09:57
// ----------------------------------------------------
// Method: F_StartWeek
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_DATE:C307($1; $0)

C_DATE:C307($date)
C_LONGINT:C283($LnumJour)

If (Count parameters:C259=1)
	$date:=$1
Else 
	$date:=Current date:C33(*)
End if 

$LnumJour:=Day number:C114($date)
If ($LnumJour=1)
	$0:=$date-6
Else 
	$0:=$date+(2-$LnumJour)
End if 