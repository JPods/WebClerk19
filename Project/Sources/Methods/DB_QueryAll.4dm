//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 07/03/19, 14:11:36
// ----------------------------------------------------
// Method: DB_AllRecords
// Description
// 
//
// Parameters
// ----------------------------------------------------

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

DB_QueryByCollection($vtResourceName; New collection:C1472)