//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/21/16, 11:25:18
// ----------------------------------------------------
// Method: ReduceSelectAll
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160921_1120 protect against deleted tables

//Method: ReduceSelectAll
C_LONGINT:C283($i; $k)
$k:=Get last table number:C254
For ($i; 2; $k)
	// ### bj ### 20181028_1159  reduce all but control
	// ### jwm ### 20160921_1120 prtect against deleted tables
	If (Is table number valid:C999($i))
		REDUCE SELECTION:C351(Table:C252($i)->; 0)
	End if 
	
End for 