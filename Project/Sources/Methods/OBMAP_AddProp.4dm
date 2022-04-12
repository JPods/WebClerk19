//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/28/20, 09:18:06
// ----------------------------------------------------
// Method: OBMAP_AddProps
// Description: 
// Usage:  $vcCollection.map("OBMAP_AddProps";New Object("NewField1";"Data1"))
// 
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($1; $voRecordWrapper)
$voRecordWrapper:=$1

C_OBJECT:C1216($2; $voPropToAdd)
$voPropToAdd:=$2


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

For each ($vtPropName; $voPropToAdd)
	
	$voRecordNew[$vtPropName]:=$voPropToAdd[$vtPropName]
	
End for each 



// ******************************************************************************************** //
// ** RETURN THE RECORD VIA THE RESULT KEY OF THE WRAPPER ************************************* //
// ******************************************************************************************** //

$voRecordWrapper.result:=$voRecordNew