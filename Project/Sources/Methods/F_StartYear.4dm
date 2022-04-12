//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 10:10:30
// ----------------------------------------------------
// Method: F_StartYear
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_DATE:C307($1; $0)

If (Count parameters:C259=0)
	$0:=Date:C102("1/1/"+String:C10(Year of:C25(Current date:C33(*))))
Else 
	$0:=Date:C102("1/1/"+String:C10(Year of:C25($1)))
End if 