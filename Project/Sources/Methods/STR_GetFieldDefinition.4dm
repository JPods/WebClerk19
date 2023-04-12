//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: STR_GetFieldDefinition
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $voFieldDefinition; $obClass; $obRec)
C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $vtFieldName)
If (Count parameters:C259=0)
	$tableName:="Customer"
	$vtFieldName:="action"
Else 
	$tableName:=$1
	$vtFieldName:=$2
End if 
$obClass:=ds:C1482[$tableName]
If ($obClass#Null:C1517)
	$voFieldDefinition:=$obClass[$vtFieldName]
End if 
$0:=$voFieldDefinition


For each ($property; $obClass)
	
End for each 



