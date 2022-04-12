//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/19, 11:06:35
// ----------------------------------------------------
// Method: SerLeadToArray
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k; $sizeArray)
$k:=Records in selection:C76([Lead:48])
FIRST RECORD:C50([Lead:48])
For ($i; 1; $k)
	$sizeArray:=SerFillRayElem("Lead"; [Lead:48]actionBy:65; [Lead:48]action:26; [Lead:48]actionDate:23; [Lead:48]actionTime:28; [Lead:48]company:5; [Lead:48]nameFirst:1+" "+[Lead:48]nameLast:2; [Lead:48]need:37; Record number:C243([Lead:48]))
	NEXT RECORD:C51([Lead:48])
End for 
REDUCE SELECTION:C351([Lead:48]; 0)
