//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/13/18, 20:00:06
// ----------------------------------------------------
// Method: taskIDReturn
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)
If ($1->=0)
	$1->:=CounterNew(->[DialingInfo:81])
	SAVE RECORD:C53(Table:C252(Table:C252($1))->)
End if 
// else drop out it already has a taskID
//