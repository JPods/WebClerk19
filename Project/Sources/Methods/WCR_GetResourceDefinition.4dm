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

C_OBJECT:C1216($0; $voResourceDefinition)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voTableDefinition; $voFieldDefinition; $voResourceOverrideConfig; $voFieldDefinitionsTemp)
C_TEXT:C284($tableName)
ARRAY TEXT:C222($atFieldNames; 0)
C_LONGINT:C283($viCounter)
C_BOOLEAN:C305($vbSkipOverrideConfig)

CREATE SET:C116([GenericChild2:91]; "TempSet_WCRGetResourceDefinition")

// ******************************************************************************************** //
// ** LOAD TABLE DEFINITION OBJECT ************************************************************ //
// ******************************************************************************************** //

QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="WebClerkResource"; *)
QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]name:3=$vtResourceName; *)
QUERY:C277([GenericChild2:91])

If (Records in selection:C76([GenericChild2:91])>0)
	$tableName:=OB Get:C1224([GenericChild2:91]obGeneral:47; "tableName")
Else 
	$tableName:=$vtResourceName
End if 

$voTableDefinition:=STR_GetTableDefinition($tableName)

// ******************************************************************************************** //
// ** APPLY THE OVERRIDE CONFIG *************************************************************** //
// ******************************************************************************************** //

$voResourceDefinition:=WCR_ApplyResourceCorrections($voTableDefinition; $vtResourceName)

// ******************************************************************************************** //
// ** APPLY FIELD OVERRIDE CONFIGS ************************************************************ //
// ******************************************************************************************** //

// UNPACK THE FIELDS OBJECT

$voFieldDefinitionsTemp:=OB Get:C1224($voResourceDefinition; "fields")

// EXTRACT AN ARRAY OF FIELDNAMES

OB GET PROPERTY NAMES:C1232($voFieldDefinitionsTemp; $atFieldNames)

// BUILD A LIST OF FIELD NAMES THAT HAVE OVERRIDE CONFIGS

QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="WebClerkResourceField"; *)
QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]a01:28=$vtResourceName; *)
QUERY:C277([GenericChild2:91])
SELECTION TO ARRAY:C260([GenericChild2:91]name:3; $atFieldNamesWithConfig)

// LOOP THROUGH THE FIELD NAMES

For ($viCounter; 1; Size of array:C274($atFieldNames))
	
	// UNPACK THE FIELD DEFINITION OBJECT
	
	$voFieldDefinition:=OB Get:C1224($voFieldDefinitionsTemp; $atFieldNames{$viCounter})
	
	// APPLY THE OVERRIDE CONFIG IF IT EXISTS
	
	$vbSkipOverrideConfig:=(Find in array:C230($atFieldNamesWithConfig; $atFieldNames{$viCounter})=-1)
	$voFieldDefinition:=WCR_ApplyFieldCorrections($voFieldDefinition; $vtResourceName; $atFieldNames{$viCounter}; $vbSkipOverrideConfig)
	
	OB SET:C1220($voFieldDefinitionsTemp; $atFieldNames{$viCounter}; $voFieldDefinition)
	
End for 

// ******************************************************************************************** //
// ** RUN CLEANUP ***************************************************************************** //
// ******************************************************************************************** //

UNLOAD RECORD:C212([GenericChild2:91])
REDUCE SELECTION:C351([GenericChild2:91]; 0)
USE SET:C118("TempSet_WCRGetResourceDefinition")
CLEAR SET:C117("TempSet_WCRGetResourceDefinition")

// ******************************************************************************************** //
// ** RETURN THE RESOURCE DEFINITION ********************************************************** //
// ******************************************************************************************** //

$0:=$voResourceDefinition
