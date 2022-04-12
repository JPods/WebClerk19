//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/26/21, 00:13:26
// ----------------------------------------------------
// Method: Init_TaskQALists
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obSelectList)
C_COLLECTION:C1488($vcChoices)
C_LONGINT:C283($inc; $cnt)
$cnt:=Size of array:C274(<>aQATypes)
$vcChoices:=New collection:C1472
For ($inc; 2; $cnt)
	$obSelectList:=New object:C1471(<>aQATypes{$inc}; <>aQATypes{$inc})
	$vcChoices.push($obSelectList)
End for 
vResponse:=JSON Stringify array:C1228($vcChoices)