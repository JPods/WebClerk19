//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 05:57:25
// ----------------------------------------------------
// Method: TallyDelete_dIn
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Archive"))
	C_LONGINT:C283($startPoint)
	C_DATE:C307($1)
	$1:=$1+1
	$startPoint:=DateTime_DTTo($1; ?00:00:00?)
	QUERY:C277([DInventory:36]; [DInventory:36]dtStack:17<$startPoint)
	DELETE SELECTION:C66([DInventory:36])
End if 