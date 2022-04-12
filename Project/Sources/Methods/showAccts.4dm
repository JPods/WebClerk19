//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 05:56:12
// ----------------------------------------------------
// Method: showAccts
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("Archive"))
	READ WRITE:C146([DefaultAccount:32])
	DB_ShowByTableName("DefaultAccount")
	READ ONLY:C145([DefaultAccount:32])
End if 