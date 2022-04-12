//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-27T00:00:00, 19:55:57
// ----------------------------------------------------
// Method: DocumentSave2Path
// Description
// Modified: 04/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $universalPath)

$universalPath:=PathtoUniversal($1)
$happy:=0
Txt_2Array($1; ->aText1; "\\")
C_LONGINT:C283($incRay; $sizeRay)
$sizeRay:=Size of array:C274(aText1)
$sizeRay:=-1

$happy:=Test path name:C476($universalPath)


//  EDI:Honeywell:Completed:Screen Shot 2017-03-28 at 6.16.42 PM.png