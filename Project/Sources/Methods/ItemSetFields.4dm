//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-12T00:00:00, 14:22:31
// ----------------------------------------------------
// Method: ItemSetFields
// Description
// Modified: 08/12/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1)
C_LONGINT:C283(pUse)
If (changeInvLines)
	OBJECT SET ENTERABLE:C238(pUse; $1)
	OBJECT SET ENTERABLE:C238(pQtyShip; $1)
	OBJECT SET ENTERABLE:C238(pPartNum; $1)
	OBJECT SET ENTERABLE:C238(pDescript; $1)
	OBJECT SET ENTERABLE:C238(pUnitPrice; $1)
	OBJECT SET ENTERABLE:C238(pDiscnt; $1)
	OBJECT SET ENTERABLE:C238(pUnitCost; $1)
End if 