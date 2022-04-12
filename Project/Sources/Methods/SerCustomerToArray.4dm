//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/19, 11:00:16
// ----------------------------------------------------
// Method: SerCustomerToArray
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k; $sizeArray)
$k:=Records in selection:C76([Customer:2])
FIRST RECORD:C50([Customer:2])
For ($i; 1; $k)
	$sizeArray:=SerFillRayElem("Customer"; [Customer:2]actionBy:139; [Customer:2]action:60; [Customer:2]actionDate:61; [Customer:2]actionTime:71; [Customer:2]company:2; [Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23; [Customer:2]need:21; Record number:C243([Customer:2]))
	NEXT RECORD:C51([Customer:2])
End for 
REDUCE SELECTION:C351([Customer:2]; 0)