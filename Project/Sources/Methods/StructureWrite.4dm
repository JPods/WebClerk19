//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/19/16, 16:03:35
// ----------------------------------------------------
// Method: StructureWrite
// Description
// AwesomeExample of Export
//
// Parameters
// ----------------------------------------------------

var $obDataStore; $obTable; $obRec : Object
var $cStructure; $cTableNames : Collection
$cStructure:=New collection:C1472
$obDataStore:=ds:C1482
var $tableName : Text
var $counter_i : Integer

$cTableNames:=STR_GetTableNameCollection
//  STR_GetFieldNameList
//  STR_GetFieldDefinition
ARRAY TEXT:C222($fields_at; 0)
var $incRay; $cntRay : Integer
For each ($obRec; $cTableNames)
	$counter_i:=$counter_i+1
	$tableName:=$obRec.tableName
	STR_GetFieldNameList($tableName; ->$fields_at)
	$obTable:=New object:C1471("tableName"; $tableName)
	For ($incRay; 1; $cntRay)
		$cStructure[String:C10($obTable)].push($obTable)
		//For each ($obField; $obDataStore[$tableName])
		//$cStructure.$vtTableName.fields[$obField.name]:=$obField
		//End for each 
	End for 
End for each 
