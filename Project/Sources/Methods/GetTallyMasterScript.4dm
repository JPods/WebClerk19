//%attributes = {}


// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/10/20, 12:04:30
// ----------------------------------------------------
// Method: GetTallyMasterScript
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtScriptText)

C_TEXT:C284($1; $vtScriptName)
$vtScriptName:=$1

C_TEXT:C284($2; $vtScriptPurpose)
$vtScriptPurpose:=$2

C_TEXT:C284($vtScriptPurpose)
$vtScriptPurpose:="@"
If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	$vtScriptPurpose:=$2
End if 

C_TEXT:C284($vtFieldName)
$vtFieldName:="Script"
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	$vtFieldName:=$3
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voRecords)


// ******************************************************************************************** //
// ** ATTEMPT TO GET THE RESOURCE OBJECT TO RESOLVE THE RESOURCE NAME TO TABLE NAME *********** //
// ******************************************************************************************** //

If (STR_IsField("TallyMaster"; $vtFieldName))
	
	$voRecords:=ds:C1482.TallyMaster.query("name = :1 AND purpose = :2"; $vtScriptName; $vtScriptPurpose)
	
	If ($voRecords.length>0)
		
		$vtScriptText:=$voRecords.first()[$vtFieldName]
		
	End if 
	
End if 

// ******************************************************************************************** //
// ** RETURN THE SCRIPT TEXT TO BE EXECUTED *************************************************** //
// ******************************************************************************************** //

$0:=$vtScriptText