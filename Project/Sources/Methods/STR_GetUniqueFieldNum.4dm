//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/09/18, 14:19:45
// ----------------------------------------------------
// Method: STR_GetUniqueFieldNum
// Description method to return the Field Number of the Unique ID for a table.
// 
//
// Parameters: 
// $1 Integer Tabel Number
// $2 boolean Absolute value default TRUE
// ----------------------------------------------------
C_TEXT:C284($1; $tableName; $vtFieldName)
C_LONGINT:C283($0; $viIndex; $viFieldNum)
C_OBJECT:C1216($obClass; $obSel; $obField)
C_LONGINT:C283($viTableNum; $viFieldNum)

$protectedFieldNum:=-1
$tableName:=$1
$obSel:=ds:C1482[$tableName].new()
If ($obSel#Null:C1517)
	$vtFieldName:=STR_GetUniqueFieldName($tableName)
	$viFieldNum:=$obSel.getDataClass()[$vtFieldName].fieldNumber
End if 
$0:=$viFieldNum