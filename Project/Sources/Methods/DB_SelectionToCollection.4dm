//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 03/18/20, 15:34:22
// ----------------------------------------------------
// Method: DB_SelectionToCollection
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_COLLECTION:C1488($0; $vcRecords)
$vcRecords:=New collection:C1472

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_TEXT:C284($vtFieldNames)  // "FieldName;FieldName;RelatedTableName_FieldName"
$vtFieldNames:=""
If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	$vtFieldNames:=$2
End if 



//*************************************************************************************//
//** TYPE AND INITIALIZE LOCAL VARIABLES **********************************************//
//*************************************************************************************//

C_TEXT:C284($vtStringifiedJSON)


//*************************************************************************************//
//** BUILD A COLLECTION WITH THE CURRENT RECORDS ON HAND ******************************//
//*************************************************************************************//

// CONVERT THE CURRENT RECORDS TO JSON

If ($vtFieldNames#"")
	$vtStringifiedJSON:=SelectionToJSON($vtResourceName; $vtFieldNames)
Else 
	$vtStringifiedJSON:=SelectionToJSON($vtResourceName)
End if 

// PARSE THE JSON INTO A COLLECTIOn

$vcRecords:=JSON Parse:C1218($vtStringifiedJSON)



//*************************************************************************************//
//** RETURN A RESPONSE ****************************************************************//
//*************************************************************************************//

$0:=$vcRecords
