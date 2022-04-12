//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/05/21, 16:52:03
// ----------------------------------------------------
// Method: Duplicates_Find
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($1; $obSel; $dataStore; $obDuplicates; $0)
C_TEXT:C284($2; $tableName)
C_TEXT:C284($3; $vtFieldName)
$obSel:=$1
$tableName:=$2
$vtFieldName:=$3
$dataStore:=$obSel.getDataClass().getDataStore()
$duplicates:=$dataStore[$tableName].query($vtFieldName+" =:1"; $obSel[$vtFieldName])
$0:=$duplicates