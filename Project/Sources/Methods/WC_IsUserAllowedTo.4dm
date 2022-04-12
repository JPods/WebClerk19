//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/27/20, 17:59:09
// ----------------------------------------------------
// Method: WC_IsUserAllowedTo
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ********************************************************************************************  //
// ** TYPE AND INITIALIZE PARAMETERS **********************************************************  //
// ********************************************************************************************  //

// RETURN VARIABLE
C_BOOLEAN:C305($0; $vbUserIsAllowedToTakeAction)
$vbUserIsAllowedToTakeAction:=False:C215

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($1; $vtAction)  // CreateRecord|EditRecord|ViewRecord|ViewRecords|ViewResourceSummary|ViewPage
$vtAction:=$1

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($2; $vtResourceNameOrURLFrag)  // customers|contacts|etc ... or /search/
$vtResourceNameOrURLFrag:=$2

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($vtUniqueID)
$vtUniqueID:=""
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	$vtUniqueID:=$3
End if 

// ********************************************************************************************  //
// ** MAKE SURE THE USER PROCESS VARIABLE IS SET **********************************************  //
// ********************************************************************************************  //

C_OBJECT:C1216(voUserDefinition)

If (OB Is defined:C1231(voUserDefinition)=False:C215)
	
	voUserDefinition:=USR_GetUserDefinition
	
	
End if 



// ********************************************************************************************  //
// ** DETERMINE IF USER IS ALLOWED TO TAKE ACTION *********************************************  //
// ********************************************************************************************  //

$vbUserIsAllowedToTakeAction:=USR_IsAllowedTo($vtAction; $vtResourceNameOrURLFrag; $vtUniqueID; voUserDefinition)
