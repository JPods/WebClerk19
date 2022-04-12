//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/25/19, 23:06:09
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

C_OBJECT:C1216($0; $voFieldDefinition)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

C_TEXT:C284($2; $vtFieldName)
$vtFieldName:=Lowercase:C14($2)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voTableFieldDefinition)
C_OBJECT:C1216($voResourceOverrideConfig)
C_TEXT:C284($tableName)

CREATE SET:C116([GenericChild2:91]; "TempSet_WCRGetFieldDefinition")

// ******************************************************************************************** //
// ** LOAD THE FIELD DEFINITION OBJECT ******************************************************** //
// ******************************************************************************************** //

QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="WebClerkResource"; *)
QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]name:3=$vtResourceName; *)
QUERY:C277([GenericChild2:91])

If (Records in selection:C76([GenericChild2:91])>0)
	$tableName:=OB Get:C1224([GenericChild2:91]obGeneral:47; "tableName")
Else 
	$tableName:=$vtResourceName
End if 

$voFieldDefinition:=STR_GetFieldDefinition($tableName; $vtFieldName)

// ******************************************************************************************** //
// ** APPLY THE OVERRIDE CONFIG *************************************************************** //
// ******************************************************************************************** //

$voFieldDefinition:=WCR_ApplyFieldCorrections($voFieldDefinition; $vtResourceName; $vtFieldName)

// ******************************************************************************************** //
// ** RUN CLEANUP ***************************************************************************** //
// ******************************************************************************************** //

UNLOAD RECORD:C212([GenericChild2:91])
REDUCE SELECTION:C351([GenericChild2:91]; 0)
USE SET:C118("TempSet_WCRGetFieldDefinition")
CLEAR SET:C117("TempSet_WCRGetFieldDefinition")

// ******************************************************************************************** //
// ** RETURN THE RESOURCE DEFINITION ********************************************************** //
// ******************************************************************************************** //

$0:=$voFieldDefinition
