//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 03/29/18, 14:11:36
// ----------------------------------------------------
// Method: DB_QueryByUniqueID
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

C_TEXT:C284($2; $vtUniqueID)
$vtUniqueID:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceDefinition)
C_TEXT:C284($vtUniqueIDFieldName)

// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID, THEN BUILD A CONDITION AND QUERY BY OBJECT ARRAY **** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	DB_QueryByCollection($vtResourceName; New collection:C1472(New object:C1471("fieldName"; $voResourceDefinition.uniqueFieldName; "value"; $vtUniqueID)))
	
End if 