//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-18T00:00:00, 16:37:47
// ----------------------------------------------------
// Method: OrderCalcArrays
// Description
// Modified: 02/18/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k; $1; $recalc)
$recalc:=0
If (Count parameters:C259>0)
	$recalc:=$1
End if 
vMod:=True:C214
OrdLnFillRays
$k:=Size of array:C274(aoLineAction)
For ($i; 1; $k)
	If ($recalc#0)
		aoLineAction{$i}:=$recalc
	End if 
	OrdLnExtend($i)
End for 
acceptOrders