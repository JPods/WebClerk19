//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/13/21, 17:42:35
// ----------------------------------------------------
// Method: STR_GetTableNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName)
C_OBJECT:C1216($obDateStore)
C_LONGINT:C283($0; $viTableNum)
$tableName:=$1

If (ds:C1482[$tableName]#Null:C1517)
	$viTableNum:=ds:C1482[$tableName].getInfo().tableNumber
End if 
$0:=$viTableNum
