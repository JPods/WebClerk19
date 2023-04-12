//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 10:10:13
// ----------------------------------------------------
// Method: WCapiTask_AddFieldsOutput
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tableName; $2; $vtRole; $0; $3; $vtFieldList; $vtNewWords)
// perhaps add a parameter to make this temporary to permanent. Perhaps an _ between Field and action
C_COLLECTION:C1488($vcWords; $vcDistinct; $vcOutput)
$tableName:=$1
$vtRole:=$2
$vcWords:=New collection:C1472
$vcWords:=Split string:C1554($3; ";")
$vcDistinct:=$vcWords.distinct()
$vcOutput:=Split string:C1554(voFieldsByRole[$vtRole].list[$tableName]; ";")
$vtNewWords:=$3
$vtFieldList:=voFieldsByRole[$vtRole].list[$tableName]
$vtFieldList:=$vtFieldList+","+$vtNewWords
//
$vtFieldList:=$vcDistinct.join()
voFieldsByRole[$vtRole].list[$tableName]:=$vtFieldList