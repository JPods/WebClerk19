//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/05/19, 10:38:07
// ----------------------------------------------------
// Method: DB_QueryByCollection
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

C_COLLECTION:C1488($vcConditions; $2)
$vcConditions:=$2

C_TEXT:C284($vtQueryModeModifier)
$vtQueryModeModifier:="Query"
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	Case of 
		: ($3="Selection")
			$vtQueryModeModifier:="Query Selection"
	End case 
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceDefinition)
C_TEXT:C284($vtDiscardedOutput)



// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// LOAD THE RESOURCE DEFINITION
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	// MERGE THE RESOURCE CONDITIONS AND THE PARAMETER CONDITIONS
	
	$vcConditions:=$voResourceDefinition.conditions.concat($vcConditions)
	
	// LOOP THROUGH THE MERGED CONDITIONS AND BUILD QUERY LINES FOR EACH, ASSEMBLING THEM INTO ONE FINAL QUERY STRING
	
	$vtQuery:=CND_CollectionToTraditional($vtResourceName; $vcConditions)
	
	// IF THERE WERE NO ERRORS, AND THE WERE MORE THAN ONE VALID CONDITIONS
	
	If (Length:C16($vtQuery)>0)
		
		// ADD FINAL CLOSING LINE TO QUERY
		
		$vtQuery:=$vtQuery+"Query(["+$voResourceDefinition.tableName+"])"
		
		$vtQuery:=Replace string:C233($vtQuery; "Query"; $vtQueryModeModifier)
		
		// EXECUTE THE QUERY
		
		$vtQuery:="<!--#4DCODE\r"+$vtQuery+"\r-->"
		PROCESS 4D TAGS:C816($vtQuery; $vtDiscardedOutput)
		
	Else 
		
		ALL RECORDS:C47(WCR_GetTablePointer($vtResourceName)->)
		
	End if 
	
End if 