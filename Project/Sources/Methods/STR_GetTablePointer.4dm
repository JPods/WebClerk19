//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: STR_GetTablePointer
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_POINTER:C301($0; $ptTable)
C_TEXT:C284($1; $tableName)
$tableName:=STR_FixCaseTableName($1)
If (ds:C1482[$tableName]#Null:C1517)
	$ptTable:=Table:C252(ds:C1482[$tableName].getInfo().tableNumber)
End if 
$0:=$ptTable
