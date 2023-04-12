//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/13/21, 18:10:35
// ----------------------------------------------------
// Method: STR_Permissions
// Description
// 
//
// Parameters
// ----------------------------------------------------





ConsoleLog("STR_Permissions")

// ******************************************************************************************** //
// ** BUILD TEMPLATE FOR EMPTY RESOURCE DEFINITION ******************************************** //
// ******************************************************************************************** //

ARRAY TEXT:C222($atEmpty; 0)
C_OBJECT:C1216($voEmpty)
$voEmpty:=JSON Parse:C1218("{}")

C_OBJECT:C1216(<>voEmptyTableDefinition)
CLEAR VARIABLE:C89(<>voEmptyTableDefinition)
OB SET:C1220(<>voEmptyTableDefinition; "tableName"; "")
OB SET:C1220(<>voEmptyTableDefinition; "tableNum"; 0)
OB SET:C1220(<>voEmptyTableDefinition; "uniqueFieldName"; "")
OB SET:C1220(<>voEmptyTableDefinition; "fields"; $voEmpty)

C_OBJECT:C1216(<>voEmptyResourceOverrideConfig)
CLEAR VARIABLE:C89(<>voEmptyResourceOverrideConfig)
OB SET ARRAY:C1227(<>voEmptyResourceOverrideConfig; "conditions"; $atEmpty)
OB SET ARRAY:C1227(<>voEmptyResourceOverrideConfig; "allowedActions"; $atEmpty)
OB SET ARRAY:C1227(<>voEmptyResourceOverrideConfig; "allowedParents"; $atEmpty)
OB SET ARRAY:C1227(<>voEmptyResourceOverrideConfig; "displayFieldNames"; $atEmpty)
OB SET:C1220(<>voEmptyResourceOverrideConfig; "approvalFieldName"; "")

C_OBJECT:C1216(<>voEmptyFieldOverrideConfig)
<>voEmptyFieldOverrideConfig:=JSON Parse:C1218("{}")