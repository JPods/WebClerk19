//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/22/21, 22:06:25
// ----------------------------------------------------
// Method: SelectList_Create
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $vtName)
$vtName:=$1
C_OBJECT:C1216($obRec)
$obRec:=ds:C1482.PopUp.new()
$obRec.arrayName:="<>a"+$vtName
$obRec.listName:="<>v"+Substring:C12($vtName; 4)
$obRec.approvedBy:="auto"
$result_o:=$obRec.save()