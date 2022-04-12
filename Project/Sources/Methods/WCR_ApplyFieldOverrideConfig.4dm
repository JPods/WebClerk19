//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/25/19, 22:46:39
// ----------------------------------------------------
// Method: WCR_ApplyFieldOverrideConfig
// Description
// 
//
// Parameters
// ----------------------------------------------------



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0)

C_OBJECT:C1216($1; $voFieldDefinition)
$voFieldDefinition:=$1

C_OBJECT:C1216($2; $voFieldOverrideConfig)
$voFieldOverrideConfig:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voTemp)
C_LONGINT:C283($viType)
C_POINTER:C301($vpTemp)

// ******************************************************************************************** //
// ** MERGE RESOURCE CONFIG OVERRIDE AND TABLE DEFINITION TO CREATE RESOURCE DEFINITION ******* //
// ******************************************************************************************** //

$voFieldDefinition:=OB_Merge($voFieldDefinition; $voFieldOverrideConfig)

// ******************************************************************************************** //
// ** CORRECT CERTAIN KEYS ******************************************************************** //
// ******************************************************************************************** //

If (OB Is defined:C1231($voFieldDefinition; "choices"))
	
	$voTemp:=OB Get:C1224($voFieldDefinition; "choices")
	
	// COPY THE VALUES TO LABELS IF LABELS AREN'T DEFINED
	
	If (OB Is defined:C1231($voFieldDefinition; "labels")=False:C215)
		
		OB_CopyField(->$voTemp; "values"; ->$voTemp; "labels")
		
	End if 
	
	// RESOLVE POSSIBLE POINTERS FOR VALUES
	
	If (OB_GetType($voTemp; "values")=Is text:K8:3)
		
		$vpTemp:=Get pointer:C304(OB Get:C1224($voTemp; "values"))
		OB REMOVE:C1226($voTemp; "values")
		
		$viType:=Type:C295($vpTemp->)
		If (($viType=Date array:K8:20) | ($viType=LongInt array:K8:19) | ($viType=Object array:K8:28) | ($viType=Real array:K8:17) | ($viType=String array:K8:15) | ($viType=Text array:K8:16) | ($viType=Time array:K8:29))
			
			OB SET ARRAY:C1227($voTemp; "values"; $vpTemp->)
			
		End if 
		
	End if 
	
	// RESOLVE POSSIBLE POINTERS FOR VALUES
	
	If (OB_GetType($voTemp; "labels")=Is text:K8:3)
		
		$vpTemp:=Get pointer:C304(OB Get:C1224($voTemp; "labels"))
		OB REMOVE:C1226($voTemp; "labels")
		
		$viType:=Type:C295($vpTemp->)
		If (($viType=Date array:K8:20) | ($viType=LongInt array:K8:19) | ($viType=Object array:K8:28) | ($viType=Real array:K8:17) | ($viType=String array:K8:15) | ($viType=Text array:K8:16) | ($viType=Time array:K8:29))
			
			OB SET ARRAY:C1227($voTemp; "labels"; $vpTemp->)
			
		End if 
		
	End if 
	
End if 

// ******************************************************************************************** //
// ** RETURN THE RESOURCE DEFINITION ********************************************************** //
// ******************************************************************************************** //

$0:=$voFieldDefinition
