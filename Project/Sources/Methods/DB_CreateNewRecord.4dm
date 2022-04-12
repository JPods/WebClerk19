//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: DB_CreateNewRecord
// Description
//
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_POINTER:C301($vpTable)


// ******************************************************************************************** //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, THEN UNLOAD RECORDS **************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// TRIGGER EVENT BEFORE CREATE
	
	DB_TriggerEvent("BeforeCreateRecord_"+$vtResourceName)
	
	// GET THE RESOURCE DEFINITION
	
	$vpTable:=WCR_GetTablePointer($vtResourceName)
	
	// CREATE THE RECORD
	
	CREATE RECORD:C68($vpTable->)
	
	// SET ALL DEFAULT VALUES
	
	DB_SetDefaultsForCurRecord($vtResourceName)
	
	// TRIGGER EVENT AFTER CREATE
	
	DB_TriggerEvent("AfterCreateRecord_"+$vtResourceName)
	
End if 
