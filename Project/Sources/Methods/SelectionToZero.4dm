//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/14/11, 14:46:20
// ----------------------------------------------------
// Method: SelectionToZero
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
		REDUCE SELECTION:C351(Table:C252($i)->; 0)
	End if 
End for 