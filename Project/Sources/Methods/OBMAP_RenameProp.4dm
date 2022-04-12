//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/28/20, 09:18:06
// ----------------------------------------------------
// Method: OBMAP_AddProps
// Description: 
// Usage:  $vcCollection.map("OBMAP_RenameProp";"PropName";"NewPropName")
// 
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($1; $voRecordWrapper)
$voRecordWrapper:=$1

C_TEXT:C284($2; $vtPropNameOld)
$vtPropNameOld:=$2

C_TEXT:C284($3; $vtPropNameNew)
$vtPropNameNew:=$3


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voRecordOriginal; $voRecordNew)
$voRecordOriginal:=$voRecordWrapper.value
$voRecordNew:=$voRecordWrapper.value



// ******************************************************************************************** //
// ** LOOP THROUGH PROPERTIES OBJECT AND ADD EACH VALUE TO OBJECT IN PARENT COLLECTION ******** //
// ******************************************************************************************** //

If (OB Is defined:C1231($voRecordOriginal; $vtPropNameOld))
	
	$voRecordNew[$vtPropNameNew]:=$voRecordOriginal[$vtPropNameOld]
	OB REMOVE:C1226($voRecordNew; $vtPropNameOld)
	
End if 



// ******************************************************************************************** //
// ** RETURN THE RECORD VIA THE RESULT KEY OF THE WRAPPER ************************************* //
// ******************************************************************************************** //

$voRecordWrapper.result:=$voRecordNew