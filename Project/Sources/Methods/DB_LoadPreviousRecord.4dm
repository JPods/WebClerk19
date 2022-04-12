//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: DB_LoadPreviousRecord
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

C_TEXT:C284($tableName)
C_POINTER:C301($vpTable)

// ******************************************************************************************** //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, THEN SWITCH TO PREVIOUS RECORD ***************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	$vpTable:=WCR_GetTablePointer($vtResourceName)
	
	PREVIOUS RECORD:C110($vpTable->)
	
End if 