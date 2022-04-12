//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:23:42
// ----------------------------------------------------
// Method: Mtl_Summary
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("Costing"))
	
	ALL RECORDS:C47([UsageSummary:33])
	curTableNum:=Table:C252(->[UsageSummary:33])
	ProcessTableOpen
End if 