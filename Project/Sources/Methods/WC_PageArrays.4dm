//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 00:37:25
// ----------------------------------------------------
// Method: WC_PageArrays
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $documentPath)
C_LONGINT:C283($0)
$documentPath:=$1

If ($documentPath="init")
	ARRAY TEXT:C222(<>aWebPagePaths; 0)
	ARRAY BLOB:C1222(<>aWebBlobs; 0)
	ARRAY TEXT:C222(<>aWebPages; 0)
	ARRAY LONGINT:C221(<>aWebPageSecurityLevel; 0)
	ARRAY LONGINT:C221(<>aWebPageTimesCalled; 0)
	ARRAY LONGINT:C221(<>aWebPageTimesSecurityFails; 0)
	
End if 