//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/19, 10:59:08
// ----------------------------------------------------
// Method: SerContactToArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k; $sizeArray)
$k:=Records in selection:C76([Contact:13])
FIRST RECORD:C50([Contact:13])
For ($i; 1; $k)
	$sizeArray:=SerFillRayElem("Contact"; [Contact:13]health:72; [Contact:13]action:32; [Contact:13]actionDate:33; [Contact:13]actionTime:34; [Contact:13]company:23; [Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4; [Contact:13]profile1:18; Record number:C243([Contact:13]))
	
	NEXT RECORD:C51([Contact:13])
	
End for 
REDUCE SELECTION:C351([Contact:13]; 0)