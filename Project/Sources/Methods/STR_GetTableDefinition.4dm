//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: STR_GetTableDefinition
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0)
C_TEXT:C284($1; $tableName)
C_OBJECT:C1216($obClass; $obSel)
C_LONGINT:C283($viTableNum)
$tableName:=$1
$obSel:=ds:C1482[$tableName].new()
If ($obSel#Null:C1517)
	$obDataClass:=$obSel.getDataClass()
End if 
$0:=$obDataClass

