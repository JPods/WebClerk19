//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/11/20, 13:45:25
// ----------------------------------------------------
// Method: ORDALearningCalls
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($1; $voPassedSel; $voRecord)

//$voPassedSel:=$1.clone()

//$voPassedSel:=$1.getSelection()
$voPassedSel:=$1


$voRecord:=$1[0]
$voRecord:=$voPassedSel[0]

C_TEXT:C284($vtText)

$vtText:=$voRecord.Company
