//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/28/20, 09:18:06
// ----------------------------------------------------
// Method: OBMAP_ExtractProperty
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

C_TEXT:C284($2; $vtPropertyToExtract)
$vtPropertyToExtract:=$2


// ******************************************************************************************** //
// ** RETURN THE RECORD VIA THE RESULT KEY OF THE WRAPPER ************************************* //
// ******************************************************************************************** //

$voRecordWrapper.result:=$voRecordWrapper.value[$vtPropertyToExtract]