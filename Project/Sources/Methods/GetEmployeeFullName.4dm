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

C_TEXT:C284($0; $vtEmployeeFullName)

C_TEXT:C284($1; $vtEmployeeNameID)
$vtEmployeeNameID:=$1



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voEmployeeRecords)


// ******************************************************************************************** //
// ** ATTEMPT TO GET THE RESOURCE OBJECT TO RESOLVE THE RESOURCE NAME TO TABLE NAME *********** //
// ******************************************************************************************** //

If (<>voEmployeeInfo=Null:C1517)
	
	Init_EmployeeObject
	
End if 

If (OB Is defined:C1231(<>voEmployeeInfo; $vtEmployeeNameID))
	
	$vtEmployeeFullName:=<>voEmployeeInfo[$vtEmployeeNameID].fullName
	
End if 



// ******************************************************************************************** //
// ** RETURN THE SCRIPT TEXT TO BE EXECUTED *************************************************** //
// ******************************************************************************************** //

$0:=$vtEmployeeFullName