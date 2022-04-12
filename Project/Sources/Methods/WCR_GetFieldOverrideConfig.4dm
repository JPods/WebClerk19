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

C_OBJECT:C1216($0; $voFieldOverrideConfig)
$voFieldOverrideConfig:=OB Copy:C1225(<>voEmptyFieldOverrideConfig)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_TEXT:C284($2; $vtFieldName)
$vtFieldName:=$2

// ******************************************************************************************** //
// ** LOAD FIELD OVERRIDE CONFIG ************************************************************** //
// ******************************************************************************************** //

CREATE SET:C116([GenericChild2:91]; "TempUserSet")

QUERY:C277([GenericChild2:91]; [GenericChild2:91]Purpose:4="WebClerkResourceField"; *)
QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]Name:3=$vtFieldName; *)
QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]A01:28=$vtResourceName; *)
QUERY:C277([GenericChild2:91])

If (Records in selection:C76([GenericChild2:91])>0)
	
	$voFieldOverrideConfig:=OB Copy:C1225([GenericChild2:91]ObGeneral:47)
	
End if 

UNLOAD RECORD:C212([GenericChild2:91])
REDUCE SELECTION:C351([GenericChild2:91]; 0)

USE SET:C118("TempUserSet")
CLEAR SET:C117("TempUserSet")

// ******************************************************************************************** //
// ** RETURN THE RESOURCE DEFINITION OR ERROR MESSSAGE **************************************** //
// ******************************************************************************************** //

$0:=$voFieldOverrideConfig
