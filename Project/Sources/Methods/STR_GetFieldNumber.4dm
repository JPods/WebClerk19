//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/19/21, 17:03:42
// ----------------------------------------------------
// Method: STR_GetFieldNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($0; $viFieldNum)
C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $vtFieldName)
C_OBJECT:C1216($obStore; $obClass; $obSel; $obField)
C_LONGINT:C283($viTableNum; $viFieldNum)

$tableName:=$1
$vtFieldName:=$2
$viFieldNum:=0
$obSel:=ds:C1482[$tableName].new()
If ($obSel#Null:C1517)
	$obClass:=$obSel.getDataClass()
	$obField:=$obClass[$vtFieldName]
	If ($obField#Null:C1517)
		$viFieldNum:=$obField.fieldNumber
	End if 
End if 
$0:=$viFieldNum
