//%attributes = {"publishedWeb":true}


// Modified by: William James (2014-08-25T00:00:00 PasswordByScript)


If (UserInPassWordGroup("AdminControl"))
	OBJECT SET ENTERABLE:C238([QQQCustomer:2]creditLimit:37; True:C214)
	GOTO OBJECT:C206([QQQCustomer:2]creditLimit:37)
End if 