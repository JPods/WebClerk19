//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: DB_IsCurRecordNew
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_BOOLEAN:C305($0; $vbCurRecordIsNew)
$vbCurRecordIsNew:=False:C215

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($tableName)
C_POINTER:C301($vpTable)

// ******************************************************************************************** //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, THEN CHECK IF THAT TABLE IS LOCKED ************* //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	$vpTable:=WCR_GetTablePointer($vtResourceName)
	
	$vbCurRecordIsNew:=Is new record:C668($vpTable->)
	
End if 

// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$0:=$vbCurRecordIsNew