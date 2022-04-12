//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/23/12, 17:00:29
// ----------------------------------------------------
// Method: MfgItemRay
// Description
// 
//
// Parameters
// ----------------------------------------------------


QUERY:C277([Item:4]; [Item:4]itemNum:1="Com"+<>aMfg{<>aMfg}+"@")
$k:=Records in selection:C76([Item:4])
ARRAY TEXT:C222(aMfgParts; $k)
ARRAY LONGINT:C221(aMfgPtRecs; $k)
FIRST RECORD:C50([Item:4])
For ($i; 1; $k)
	aMfgParts{$i}:=[Item:4]itemNum:1
	aMfgPtRecs{$i}:=Record number:C243([Item:4])
	NEXT RECORD:C51([Item:4])
End for 
UNLOAD RECORD:C212([Item:4])