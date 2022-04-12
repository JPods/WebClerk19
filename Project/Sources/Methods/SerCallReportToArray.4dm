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
$k:=Records in selection:C76([CallReport:34])
FIRST RECORD:C50([CallReport:34])
C_DATE:C307($vActionDate)
C_TIME:C306($vActionTime)
For ($i; 1; $k)
	jDateTimeRecov([CallReport:34]dtAction:4; ->$vActionDate; ->$vActionTime)
	$sizeArray:=SerFillRayElem("CallReport"; [CallReport:34]actionBy:3; [CallReport:34]action:15; $vActionDate; $vActionTime; [CallReport:34]company:42; [CallReport:34]attention:18; [CallReport:34]status:34; Record number:C243([CallReport:34]))
	
	NEXT RECORD:C51([CallReport:34])
	
End for 
REDUCE SELECTION:C351([CallReport:34]; 0)