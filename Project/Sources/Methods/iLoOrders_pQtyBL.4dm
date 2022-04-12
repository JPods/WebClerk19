//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-14T00:00:00, 11:55:09
// ----------------------------------------------------
// Method: iLoOrders_pQtyBL
// Description
// Modified: 08/14/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

aOQtyBL{aoLineAction}:=pQtyBackOrd
pQtyOrd:=pQtyBackOrd+pQtyShip
aOQtyOrder{aoLineAction}:=pQtyOrd
If (aoLineAction{aoLineAction}#-3)
	aoLineAction{aoLineAction}:=-3000  // set line to recalc
End if 
vLineMod:=True:C214