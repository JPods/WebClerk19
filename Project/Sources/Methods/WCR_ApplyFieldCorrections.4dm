//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/25/19, 22:46:04
// ----------------------------------------------------
// Method: WCR_ApplyFieldCorrections
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0)

C_OBJECT:C1216($1; $voTableDefinition)
$voTableDefinition:=$1

C_TEXT:C284($2; $vtResourceName)
$vtResourceName:=$2

C_BOOLEAN:C305($vbSkipOverrideConfig)
If (Count parameters:C259>=4)
	C_BOOLEAN:C305($4)
	$vbSkipOverrideConfig:=$4
Else 
	$vbSkipOverrideConfig:=False:C215
End if 

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceOverrideConfig)
$voResourceOverrideConfig:=OB Copy:C1225(<>voEmptyResourceOverrideConfig)

// ******************************************************************************************** //
// ** LOAD THE RESOURCE OVERRID CONFIG, THEN MERGE IT DOWN ONTO THE RESOURCE DEFINITION ******* //
// ******************************************************************************************** //

If ($vbSkipOverrideConfig=False:C215)
	
	QUERY:C277([GenericChild2:91]; [GenericChild2:91]Purpose:4="WebClerkResource"; *)
	QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]Name:3=$vtResourceName; *)
	QUERY:C277([GenericChild2:91])
	
	If (Records in selection:C76([GenericChild2:91])>0)
		
		$voResourceOverrideConfig:=OB Copy:C1225([GenericChild2:91]ObGeneral:47)
		
	End if 
	
	$voFieldDefinition:=OB_Merge($voTableDefinition; $voResourceOverrideConfig)
	
End if 

// ******************************************************************************************** //
// ** RETURN THE RESOURCE DEFINITION ********************************************************** //
// ******************************************************************************************** //

$0:=$voFieldDefinition
