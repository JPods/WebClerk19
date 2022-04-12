//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 09:16:09
// ----------------------------------------------------
// Method: showReps
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("ViewCommission"))
	DB_ShowByTableName("Rep")
End if 