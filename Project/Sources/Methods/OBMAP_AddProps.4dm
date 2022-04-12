//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/28/20, 09:18:06
// ----------------------------------------------------
// Method: OBMAP_AddProps
// Description: 
// Usage:  $vcCollection.map("OBMAP_AddProps";New Collection(New Object("NewField1";"Data1");New Object("NewField2";"Data2")))
// 
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($1; $voRecordWrapper)
$voRecordWrapper:=$1

C_COLLECTION:C1488($2; $vcPropsToAdd)
$vcPropsToAdd:=$2


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voProp)

C_TEXT:C284($vtPropName)

C_OBJECT:C1216($voRecordOriginal; $voRecordNew)
$voRecordOriginal:=$voRecordWrapper.value
$voRecordNew:=$voRecordWrapper.value



// ******************************************************************************************** //
// ** LOOP THROUGH PROPERTIES OBJECT AND ADD EACH VALUE TO OBJECT IN PARENT COLLECTION ******** //
// ******************************************************************************************** //

For each ($voProp; $vcPropsToAdd)
	
	For each ($vtPropName; $voProp)
		
		$voRecordNew[$vtPropName]:=$voProp[$vtPropName]
		
	End for each 
	
End for each 



// ******************************************************************************************** //
// ** RETURN THE RECORD VIA THE RESULT KEY OF THE WRAPPER ************************************* //
// ******************************************************************************************** //

$voRecordWrapper.result:=$voRecordNew