//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/17/19, 11:15:54
// ----------------------------------------------------
// Method: WCR_GetResourceDefinition
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $voResourceFieldDefinition)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_TEXT:C284($2; $vtFieldName)
$vtFieldName:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voTableFieldDefinition)
C_OBJECT:C1216($voResourceOverrideConfig)

// ******************************************************************************************** //
// ** LOAD RESOURCE CONFIG OVERRIDE AND TABLE DEFINITION ************************************** //
// ******************************************************************************************** //

$voResourceOverrideConfig:=WCR_GetFieldOverrideConfig($vtResourceName)

$voTableFieldDefinition:=STR_GetFieldDefinition(WCR_GetTableName($vtResourceName); $vtFieldName)

// ******************************************************************************************** //
// ** MERGE RESOURCE CONFIG OVERRIDE AND TABLE DEFINITION TO CREATE RESOURCE DEFINITION ******* //
// ******************************************************************************************** //

$voResourceFieldDefinition:=OB_Merge($voTableFieldDefinition; $voResourceOverrideConfig)

// ******************************************************************************************** //
// ** CORRECT CERTAIN KEYS ******************************************************************** //
// ******************************************************************************************** //

OB SET:C1220($voResourceFieldDefinition; "fieldNum"; OB Get:C1224($voResourceFieldDefinition; "num"))
OB REMOVE:C1226($voResourceFieldDefinition; "num")

// ******************************************************************************************** //
// ** RETURN THE RESOURCE DEFINITION ********************************************************** //
// ******************************************************************************************** //

$0:=$voResourceFieldDefinition
