//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/12/20, 18:54:09
// ----------------------------------------------------
// Method: DB_GetCurRecordTitle
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ********************************************************************************************  //
// ** TYPE AND INITIALIZE PARAMETERS **********************************************************  //
// ********************************************************************************************  //

C_TEXT:C284($0; $vtTitleValue)
$vtTitleValue:=""

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

// ********************************************************************************************  //
// ** TYPE AND INITIALIZE LOCAL VARIABLES *****************************************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voResourceDefinition)
C_TEXT:C284($vtTitleTemplate)


// ********************************************************************************************  //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, THEN UNLOAD RECORDS ****************************  //
// ********************************************************************************************  //

If (WCR_IsResource($vtResourceName))
	
	// GET RESOURCE INFO
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	If (DB_RecordsInSelection($vtResourceName)>0)
		
		// LOAD THE TITLE TEMPLATE
		
		If (OB Is defined:C1231($voResourceDefinition; "titleTemplate"))
			$vtTitleTemplate:=$voResourceDefinition.titleTemplate
		Else 
			$vtTitleTemplate:="String(["+$voResourceDefinition.tableName+"]"+$voResourceDefinition.uniqueFieldName+")"
		End if 
		
		// EXECUTE THE TEMPLATE
		
		$vtTitleValue:=ExecuteTemplate($vtTitleTemplate)
		
	End if 
	
End if 

$0:=$vtTitleValue
