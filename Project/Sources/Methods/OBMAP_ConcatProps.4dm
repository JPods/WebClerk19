//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/28/20, 09:18:06
// ----------------------------------------------------
// Method: OBMAP_ConcatProperties
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($1; $voRecordWrapper)
$voRecordWrapper:=$1

C_COLLECTION:C1488($2; $vcFieldNamesToCombine)
$vcFieldNamesToCombine:=$2

C_TEXT:C284($3; $vtNewFieldName)
$vtNewFieldName:=$3

C_TEXT:C284($vtDelimitor)
$vtDelimitor:=" "
If (Count parameters:C259>=4)
	C_TEXT:C284($4)
	$vtDelimitor:=$4
End if 

C_BOOLEAN:C305($vbRemoveOriginalProperties)
$vbRemoveOriginalProperties:=True:C214
If (Count parameters:C259>=5)
	C_BOOLEAN:C305($5)
	$vbRemoveOriginalProperties:=$5
End if 


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_COLLECTION:C1488($vcValues)
$vcValues:=New collection:C1472

C_OBJECT:C1216($voRecordOriginal; $voRecordNew)
$voRecordOriginal:=$voRecordWrapper.value
$voRecordNew:=$voRecordWrapper.value

C_TEXT:C284($vtFieldName)



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

For each ($vtFieldName; $vcFieldNamesToCombine)
	
	If (OB Is defined:C1231($voRecordOriginal; $vtFieldName))
		
		$vcValues.push(String:C10($voRecordOriginal[$vtFieldName]))
		If ($vbRemoveOriginalProperties)
			OB REMOVE:C1226($voRecordNew; $vtFieldName)
		End if 
		
	End if 
	
End for each 

$voRecordNew[$vtNewFieldName]:=$vcValues.join($vtDelimitor)



// ******************************************************************************************** //
// ** RETURN THE RECORD VIA THE RESULT KEY OF THE WRAPPER ************************************* //
// ******************************************************************************************** //

$voRecordWrapper.result:=$voRecordNew