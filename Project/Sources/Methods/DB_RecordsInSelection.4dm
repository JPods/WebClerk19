//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 07/23/19, 11:15:54
// ----------------------------------------------------
// Method: DB_RecordsInSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($0; $viRecordsInSelection)
$viRecordsInSelection:=0

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($tableName)
C_POINTER:C301($vpTable)
C_OBJECT:C1216($voResourceDefinition; $voAllRecordsInResource)

// ******************************************************************************************** //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, TO GET THE NUMBER OF RECORDS IN SELECTION ****** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	If (DB_IsCurRecordNew($vtResourceName))
		
		$viRecordsInSelection:=1
		
	Else 
		
		$vpTable:=WCR_GetTablePointer($vtResourceName)
		$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
		
		// GET CURRENT SELECTION
		
		$voRecordsInCurrentSelection:=Create entity selection:C1512($vpTable->)
		
		// FILTER DOWN TO RESOURCE ONLY
		
		$voQuery:=CND_CollectionToORDA($vtResourceName; $voResourceDefinition.conditions)
		
		If ($voQuery.querySettings.parameters.length>0)
			
			$voAllRecordsInResource:=ds:C1482[$voResourceDefinition.tableName].query($voQuery.string; $voQuery.querySettings)
			
			$viRecordsInSelection:=$voRecordsInCurrentSelection.and($voAllRecordsInResource).length
			
		Else 
			
			$viRecordsInSelection:=$voRecordsInCurrentSelection.length
			
		End if 
		
	End if 
	
End if 


// ******************************************************************************************** //
// ** RETURN NUMBER OF RECORDS IN SELECTION *************************************************** //
// ******************************************************************************************** //

$0:=$viRecordsInSelection
