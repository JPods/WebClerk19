//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-05T00:00:00, 11:36:20
// ----------------------------------------------------
// Method: PpLnFillRec
// Description
// Modified: 10/05/16
// 
// 
//
// Parameters
// ----------------------------------------------------

// similar to POLn_RaySize (3;0;0)
C_LONGINT:C283($k; $i; $orig)
$k:=Size of array:C274(aPItemNum)
If ($k>0)
	PpLn_RaySize(3; 0; 0)  //
Else 
	PpLnInitRays
End if 
READ ONLY:C145([ProposalLine:43])