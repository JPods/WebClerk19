//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 07/23/19, 11:15:54
// ----------------------------------------------------
// Method: WCR_RecordsInSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

ConsoleLog("Please replace usage of WCR_GetResource with WCR_GetResourceDefinition.")
$0:=WCR_GetResourceDefinition($vtResourceName)