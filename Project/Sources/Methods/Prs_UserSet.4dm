//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/25/13, 02:15:11
// ----------------------------------------------------
// Method: Prs_UserSet
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	
	UNLOAD RECORD:C212(ptCurTable->)
	ProcessTableOpen(Table:C252(ptCurTable); "UserSet")
	
End if 