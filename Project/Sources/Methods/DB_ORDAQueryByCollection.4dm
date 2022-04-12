//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/05/19, 10:38:07
// ----------------------------------------------------
// Method: DB_ORDAQueryByCollection
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

C_COLLECTION:C1488($vcConditions; $2)
$vcConditions:=$2



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceDefinition)



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// LOAD THE RESOURCE DEFINITION
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	// MERGE THE RESOURCE CONDITIONS AND THE PARAMETER CONDITIONS
	
	$vcConditions:=$voResourceDefinition.conditions.concat($vcConditions)
	
	// LOOP THROUGH THE MERGED CONDITIONS AND BUILD QUERY LINES FOR EACH, ASSEMBLING THEM INTO ONE FINAL QUERY STRING
	
	$vtQuery:=CND_CollectionToORDAString($vtResourceName; $vcConditions)
	
	// IF THERE WERE NO ERRORS, AND THE WERE MORE THAN ONE VALID CONDITIONS
	
	If (Length:C16($vtQuery)>0)
		
		// ADD FINAL CLOSING LINE TO QUERY
		
		$voRecords:=ds:C1482[$voResourceDefinition.tableName].query($vtQuery)
		
	Else 
		
		$voRecords:=ds:C1482[$voResourceDefinition.tableName].all()
		
	End if 
	
End if 



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** //

$0:=$voRecords