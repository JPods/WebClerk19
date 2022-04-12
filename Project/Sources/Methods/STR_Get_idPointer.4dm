//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/13/21, 23:56:37
// ----------------------------------------------------
// Method: STR_Get_idPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($0; $ptField)
C_TEXT:C284($1; $tableName)
C_OBJECT:C1216($obStore; $obClass; $obSel)
C_LONGINT:C283($viTableNum; $viFieldNum)
$tableName:=$1

//$obSel:=ds[$tableName].new()  // these steps to the same as getting the class directly
//$obClass:=$obSel.getDataClass()

$obClass:=ds:C1482[$tableName]
If ($obClass#Null:C1517)
	$viTableNum:=$obClass.getInfo().tableNumber
	$viFieldNum:=$obClass.id.fieldNumber
	$ptField:=Field:C253($viTableNum; $viFieldNum)
End if 
$0:=$ptField

