//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/19, 11:10:31
// ----------------------------------------------------
// Method: SerCallReportToArray
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k; $sizeArray)
$k:=Records in selection:C76([Call:34])
FIRST RECORD:C50([Call:34])
C_DATE:C307($vActionDate)
C_TIME:C306($vActionTime)
For ($i; 1; $k)
	DateTime_DTFrom([Call:34]dtAction:4; ->$vActionDate; ->$vActionTime)
	$sizeArray:=SerFillRayElem("CallReport"; [Call:34]actionBy:3; [Call:34]action:15; $vActionDate; $vActionTime; [Call:34]company:42; [Call:34]attention:18; [Call:34]status:34; Record number:C243([Call:34]))
	
	NEXT RECORD:C51([Call:34])
	
End for 
REDUCE SELECTION:C351([Call:34]; 0)