//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/28/20, 09:18:06
// ----------------------------------------------------
// Method: OBMAP_AddProps
// Description: 
// Usage:  $vcCollection.map("OBMAP_RemoveProp";"Property1")
// 
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($1; $voRecordWrapper)
$voRecordWrapper:=$1

C_TEXT:C284($2; $vtPropNameToRemove)
$vtPropNameToRemove:=$2


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($vtPropName)

C_OBJECT:C1216($voRecordOriginal; $voRecordNew)
$voRecordOriginal:=$voRecordWrapper.value
$voRecordNew:=$voRecordWrapper.value


// ******************************************************************************************** //
// ** LOOP THROUGH PROPERTIES OBJECT AND ADD EACH VALUE TO OBJECT IN PARENT COLLECTION ******** //
// ******************************************************************************************** //

If (OB Is defined:C1231($voRecordNew; $vtPropNameToRemove))
	
	OB REMOVE:C1226($voRecordNew; $vtPropNameToRemove)
	
End if 



// ******************************************************************************************** //
// ** RETURN THE RECORD VIA THE RESULT KEY OF THE WRAPPER ************************************* //
// ******************************************************************************************** //

$voRecordWrapper.result:=$voRecordNew