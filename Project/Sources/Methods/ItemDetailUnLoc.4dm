//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 09:11:57
// ----------------------------------------------------
// Method: ItemDetailUnLoc
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("UnlockRecord"))
	If ((changeInvLines) | (ptCUrTable#(->[Invoice:26])))
		OBJECT SET ENTERABLE:C238(pQtyOrd; True:C214)
		OBJECT SET ENTERABLE:C238(pQtyBL; True:C214)
		OBJECT SET ENTERABLE:C238(pQtyShip; True:C214)
		OBJECT SET ENTERABLE:C238(pUnitCost; True:C214)
		GOTO OBJECT:C206(pQtyShip)
	End if 
End if 