//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 21:20:51
// ----------------------------------------------------
// Method: API_SelectionToObject
// Description
//   SelectionToJSON
//// $employees:=Create entity selection([Employee])
////USE ENTITY SELECTION
// Convert selection to entity
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tableName)
C_POINTER:C301($ptTable)
C_OBJECT:C1216($veSelection; $0)
$tableName:=$1
$ptTable:=STR_GetTablePointer($tableName)
If (Is nil pointer:C315($ptTable))
	$0:=New object:C1471
Else 
	$0:=Create entity selection:C1512($ptTable->)
End if 

