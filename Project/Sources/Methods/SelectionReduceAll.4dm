//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/14/12, 22:43:35
// ----------------------------------------------------
// Method: Method: SelectionReduceAll
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
$k:=Get last table number:C254
For ($i; 1; $k)
	If (Records in selection:C76(Table:C252($i)->)>0)
		UNLOAD RECORD:C212(Table:C252($i)->)
	End if 
End for 