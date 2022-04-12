//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:22:36
// ----------------------------------------------------
// Method: Mtl_Monthly
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("Costing"))
	
	ALL RECORDS:C47([Usage:5])
	curTableNum:=Table:C252(->[Usage:5])
	ProcessTableOpen
End if 