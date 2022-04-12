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

C_LONGINT:C283($0)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

ConsoleMessage("Please replace usage of WCR_RecordsInSelection with DB_RecordsInSelection.")
$0:=DB_RecordsInSelection($vtResourceName)