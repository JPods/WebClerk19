//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/20/19, 15:24:50
// ----------------------------------------------------
// Method: SerServiceToArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k; $sizeArray)
$k:=Records in selection:C76([Service:6])
FIRST RECORD:C50([Service:6])
C_DATE:C307($vActionDate)
C_TIME:C306($vActionTime)
For ($i; 1; $k)
	DateTime_DTFrom([Service:6]dtAction:35; ->$vActionDate; ->$vActionTime)
	$sizeArray:=SerFillRayElem("Service"; [Service:6]actionBy:12; [Service:6]action:20; $vActionDate; $vActionTime; [Service:6]company:48; [Service:6]attention:30; [Service:6]description:50; Record number:C243([Service:6]))
	NEXT RECORD:C51([Service:6])
End for 
REDUCE SELECTION:C351([Service:6]; 0)