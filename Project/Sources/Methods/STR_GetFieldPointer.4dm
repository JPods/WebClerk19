//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: STR_GetFieldPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_POINTER:C301($0; $ptField; $ptFieldArray)
C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $vtFieldName; $3; $vtCheck)
C_OBJECT:C1216($obStore; $obClass; $obSel; $obField)
C_LONGINT:C283($viTableNum; $viFieldNum)
If (Count parameters:C259>2)
	$vtCheck:=$3
End if 

$ptField:=Null:C1517
// perhaps should remove the case checking someday
If ($vtCheck="@check@")
	$tableName:=STR_FixCaseTableName($1)
Else 
	$tableName:=$1
End if 
$obClass:=ds:C1482[$tableName]
If ($obClass#Null:C1517)
	// $obClass:=$obSel.getDataClass()
	$viTableNum:=$obClass.getInfo().tableNumber
	If ($vtCheck="@check@")
		$vtFieldName:=STR_FixCaseFieldName($tableName; $2)
	Else 
		$vtFieldName:=$2
	End if 
	$obField:=$obClass[$vtFieldName]
	If ($obField#Null:C1517)
		$viFieldNum:=$obField.fieldNumber
		$ptField:=Field:C253($viTableNum; $viFieldNum)
	End if 
End if 
$0:=$ptField
