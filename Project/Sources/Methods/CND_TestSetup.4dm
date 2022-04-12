//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/01/21, 11:35:09
// ----------------------------------------------------
// Method: CND_TestSetup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($vtResourceName)
C_COLLECTION:C1488($vcConditions)
C_OBJECT:C1216($voQuery)



$vtResourceName:="ResourceTest"
//$vcConditions:=New collection("id"
$vcConditions.value:="Testing"
TRACE:C157
$voQuery:=CND_CollectionToORDA($vtResourceName; $vcConditions)

TRACE:C157
