//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/06/19, 09:13:55
// ----------------------------------------------------
// Method: DB_QueryByConditionsString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_TEXT:C284($vtConditionsString)  //"Company=@79@;&;SalesYtD>=1000"
$vtConditionsString:=""
If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	$vtConditionsString:=$2
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_COLLECTION:C1488($vcAllConditionsParts)
$vcAllConditionsParts:=New collection:C1472

C_COLLECTION:C1488($vcOneConditionParts)
$vcOneConditionParts:=New collection:C1472

C_COLLECTION:C1488($vcPossibleOperators)
$vcPossibleOperators:=New collection:C1472(">="; "<="; ">"; "<"; "#"; "=")

C_TEXT:C284($vtPossibleOperator)

C_TEXT:C284($vtCondition; $vtOperator; $vtBoolean; $vtFieldName; $vtValue)

C_TEXT:C284($vtQuery; $vtDiscardedOutput)
$vtQuery:=""

C_LONGINT:C283($viCountValidConditions)
$viCountValidConditions:=0

// ******************************************************************************************** //
// ** MAKE SURE THE RESOURCE IS VALID ********************************************************* //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// LOAD THE RESOURCE INFORMATION
	
	$voResourceDefinion:=WCR_GetResourceDefinition($vtResourceName)
	$tableName:=$voResourceDefinion.tableName
	
	// PARSE CONDITIONS STRING
	
	$vcAllConditionsParts:=Split string:C1554($vtConditionsString; ";")
	
	// LOOP THROUGH CONDITIONS PARTS AND VALIDATE THEM, BEFORE BUILDING QUERY STRING
	
	If ($vcAllConditionsParts.length>0)
		
		For ($viCounter; 0; $vcAllConditionsParts.length; 2)
			
			// SEPARATE OUT THE CONDITION FROM THE BOOLEAN
			
			$vtCondition:=$vcAllConditionsParts[$viCounter]
			
			If ($viCounter>0)
				$vtBoolean:=$vcAllConditionsParts[$viCounter-1]
			Else 
				$vtBoolean:=""
			End if 
			
			// DETERMINE WHICH OPERATOR IS IN THE CONDITION
			$vtOperator:=""
			For each ($vtPossibleOperator; $vcPossibleOperators)
				If ((Position:C15($vtPossibleOperator; $vtCondition)>0) & ($vtOperator=""))
					$vtOperator:=$vtPossibleOperator
				End if 
			End for each 
			
			// SPLIT THE CONDITION USING THE OPERATOR INTO THE FIELD NAME AND VALUE
			
			$vcOneConditionParts:=Split string:C1554($vtCondition; $vtOperator)
			
			$vtFieldName:=$vcOneConditionParts[0]
			$vtValue:=$vcOneConditionParts[1]
			
			// CONFIRM THE FIELD NAME IS A VALID FIELD
			
			If (WCR_IsField($vtResourceName; $vtFieldName))
				
				// SANITIZE THE INPUT
				
				$vtValue:=SanitizeInput($vtValue; WCR_GetFieldPointer($vtResourceName; $vtFieldName))
				
				$vtQuery:=$vtQuery+"Query Selection(["+$tableName+"];"+$vtBoolean+"["+$tableName+"]"+$vtFieldName+$vtOperator+$vtValue+";*)"+"\r"
				
				$viCountValidConditions:=$viCountValidConditions+1
				
			End if 
			
		End for 
		
	End if 
	// LOAD ALL RECORDS IN THE RESOURCE
	
	DB_QueryAll($vtResourceName)
	
	// IF WE HAVE VALID CONDITIONS, FILTER BY THEM
	
	If ($viCountValidConditions>0)
		
		// ADD FINAL CLOSING LINE TO QUERY
		
		$vtQuery:=$vtQuery+"Query Selection(["+$tableName+"])"
		
		// EXECUTE THE QUERY
		
		$vtQuery:="<!--#4DCODE\r"+$vtQuery+"\r-->"
		PROCESS 4D TAGS:C816($vtQuery; $vtDiscardedOutput)
		
	End if 
	
End if 