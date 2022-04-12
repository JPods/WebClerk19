//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: WCR_GetFieldDefinition
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

C_POINTER:C301($2; $vpatFieldNameList)
$vpatFieldNameList:=$2


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceDefinition)
C_OBJECT:C1216($voFieldDefinitions)

// ******************************************************************************************** //
// ** CONFIRM THAT THE TABLE IS VALID, AND IF SO, LOAD IT'S DEFINITION ************************ //
// ******************************************************************************************** //

$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
$voFieldDefinitions:=OB Get:C1224($voResourceDefinition; "fields")
OB GET PROPERTY NAMES:C1232($voFieldDefinitions; $vpatFieldNameList->)