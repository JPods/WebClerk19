//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/26/21, 20:24:15
// ----------------------------------------------------
// Method: Init_CustomerQALists
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obSelectList)
C_COLLECTION:C1488($vcChoices)
C_LONGINT:C283($inc; $cnt)
ARRAY TEXT:C222($atList; 1)
$atList{1}:="Site-Inspection"
$cnt:=Size of array:C274($atList)
$vcChoices:=New collection:C1472
For ($inc; 1; $cnt)
	$obSelectList:=New object:C1471($atList{$inc}; $atList{$inc})
	$vcChoices.push($obSelectList)
End for 
vResponse:=JSON Stringify array:C1228($vcChoices)