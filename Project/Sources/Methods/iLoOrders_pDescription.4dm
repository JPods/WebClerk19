//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-14T00:00:00, 12:00:36
// ----------------------------------------------------
// Method: iLoOrders_pDescription
// Description
// Modified: 08/14/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


aODescpt{aoLineAction}:=pDescript
If (aoLineAction{aoLineAction}#-3)  // set line to recalc
	aoLineAction{aoLineAction}:=-3000  // set line to recalc
End if 
vLineMod:=True:C214