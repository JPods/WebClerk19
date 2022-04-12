//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-06T00:00:00, 15:32:41
// ----------------------------------------------------
// Method: PpLnFillRays
// Description
// Modified: 10/06/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $lnTest)
C_LONGINT:C283($k)
viBoxCnt:=0
$k:=Records in selection:C76([ProposalLine:43])
viPrplLnCnt:=0
//TRACE
If ($k>0)
	
	PpLn_RaySize(2; 0; 0)
	
Else 
	PpLnInitRays
End if 