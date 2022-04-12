//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 01/13/20, 11:58:28
// ----------------------------------------------------
// Method: DB_ORDADB_QueryByUniqueID
// Description
// 
//
// Parameters
// ----------------------------------------------------
//
// Usage: DB_ORDADB_QueryByUniqueID($vtResourceName;$vtUniqueID)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $voSelection)
$voSelection:=New object:C1471

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_TEXT:C284($2; $vtUniqueID)
$vtUniqueID:=$2



//*************************************************************************************//
//** CHECK TO SEE IF THE CURRENT RECORD BELONGS TO THE USER ***************************//
//*************************************************************************************//

If (WCR_IsResource($vtResourceName))
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	$voSelection:=DB_ORDAQueryByString($vtResourceName; $voResourceDefinition.uniqueFieldName+" = "+$vtUniqueID)
	
End if 



//*************************************************************************************//
//** RETURN THE RESULT ****************************************************************//
//*************************************************************************************//

$0:=$voSelection