//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/05/19, 10:38:07
// ----------------------------------------------------
// Method: DB_ORDAQueryByString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $voRecords)
$voRecords:=New object:C1471

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

C_TEXT:C284($vtConditions; $2)
$vtConditions:=$2



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceDefinition)
C_TEXT:C284($vtResourceConditions)



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// LOAD THE RESOURCE DEFINITION
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	// LOOP THROUGH THE MERGED CONDITIONS AND BUILD QUERY LINES FOR EACH, ASSEMBLING THEM INTO ONE FINAL QUERY STRING
	
	$vtResourceConditions:=CND_CollectionToORDAString($vtResourceName; $voResourceDefinition.conditions)
	
	// IF THERE WERE NO ERRORS, AND THE WERE MORE THAN ONE VALID CONDITIONS
	
	If (Length:C16($vtResourceConditions)>0)
		
		$vtResourceConditions:=$vtResourceConditions+" AND "
		
	End if 
	
	$voRecords:=ds:C1482[$voResourceDefinition.tableName].query($vtResourceConditions+$vtConditions)
	
End if 



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** //

$0:=$voRecords