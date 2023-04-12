//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/18/21, 23:53:36
// ----------------------------------------------------
// Method: FieldList_ForceUUIDFirst
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0; $vtFieldList)
$vtFieldList:=$1
C_COLLECTION:C1488($vcWords; $vcDistinct; $vcOutput)
C_LONGINT:C283($viFound)
$vcFields:=New collection:C1472
$vcWords:=Split string:C1554($vtFieldList; ";")
$vcWords.insert(0; "id")
$vcDistinct:=$vcWords.distinct()
$vtFieldList:=$vcDistinct.join(";")
$0:=$vtFieldList