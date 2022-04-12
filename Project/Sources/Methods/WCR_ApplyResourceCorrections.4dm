//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/25/19, 23:05:47
// ----------------------------------------------------
// Method: WCR_ApplyResourceCorrections
// Description
// 
//
// Parameters
// ----------------------------------------------------


//<declarations>
//==================================
//  Type variables 
//==================================

// $0;$1;$2;$3
C_BOOLEAN:C305($vbSkipOverrideConfig)
C_TEXT:C284($vtResourceName)
C_OBJECT:C1216(<>voEmptyResourceOverrideConfig; $voFieldDefinition; $voResourceOverrideConfig; $voTableDefinition)

//==================================
//  Initialize variables 
//==================================

$vbSkipOverrideConfig:=False:C215
$vtResourceName:=""

C_BOOLEAN:C305($vbDefined)
$vbDefined:=OB Is defined:C1231(<>voEmptyResourceOverrideConfig)
$vbDefined:=OB Is defined:C1231($voFieldDefinition)
$vbDefined:=OB Is defined:C1231($voResourceOverrideConfig)
$vbDefined:=OB Is defined:C1231($voTableDefinition)
//</declarations>


// ********************************************************************************************  //
// ** TYPE AND INITIALIZE PARAMETERS **********************************************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($0)

C_OBJECT:C1216($1; $voTableDefinition)
$voTableDefinition:=$1

C_TEXT:C284($2; $vtResourceName)
$vtResourceName:=$2

C_BOOLEAN:C305($vbSkipOverrideConfig)
If (Count parameters:C259>=4)
	C_BOOLEAN:C305($3)
	$vbSkipOverrideConfig:=$3
Else 
	$vbSkipOverrideConfig:=False:C215
End if 

// ********************************************************************************************  //
// ** TYPE AND INITIALIZE LOCAL VARIABLES *****************************************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voResourceOverrideConfig)
$voResourceOverrideConfig:=OB Copy:C1225(<>voEmptyResourceOverrideConfig)

// ********************************************************************************************  //
// ** LOAD THE RESOURCE OVERRID CONFIG, THEN MERGE IT DOWN ONTO THE RESOURCE DEFINITION *******  //
// ********************************************************************************************  //

If ($vbSkipOverrideConfig=False:C215)
	
	QUERY:C277([GenericChild2:91]; [GenericChild2:91]Purpose:4="WebClerkResource"; *)
	QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]Name:3=$vtResourceName; *)
	QUERY:C277([GenericChild2:91])
	
	If (Records in selection:C76([GenericChild2:91])>0)
		
		$voResourceOverrideConfig:=OB Copy:C1225([GenericChild2:91]ObGeneral:47)
		
	End if 
	
	$voFieldDefinition:=OB_Merge($voTableDefinition; $voResourceOverrideConfig)
	
End if 

// ********************************************************************************************  //
// ** RETURN THE RESOURCE DEFINITION **********************************************************  //
// ********************************************************************************************  //

$0:=$voFieldDefinition
