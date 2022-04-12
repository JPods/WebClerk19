//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:26:13
// ----------------------------------------------------
// Method: ApprvlDiscount
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("Credit"))
	OBJECT SET ENTERABLE:C238([QQQCustomer:2]discount:36; True:C214)
	GOTO OBJECT:C206([QQQCustomer:2]discount:36)
End if 