//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/05/19, 10:38:07
// ----------------------------------------------------
// Method: DB_QueryByObjectArray
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtQuery)
$vtQuery:=""

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

C_POINTER:C301($vpaoConditions; $2)
$vpaoConditions:=$2

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

C_TEXT:C284($tableName)
C_BOOLEAN:C305($vbError)
C_LONGINT:C283($viCounter)
C_OBJECT:C1216($voResourceDefinition)
C_TEXT:C284($vtDiscardedOutput)
ARRAY OBJECT:C1221($aoResourceConditions; 0)
C_TEXT:C284($vtFieldName; $vtOperator; $vtValue; $vtBoolean)
C_BOOLEAN:C305($vbQueryOperatorNot)
C_LONGINT:C283($viCountValidConditions)

// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// LOAD THE RESOURCE DEFINITION
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	// UNPACK THE TABLE NAME AND RESOURCE CONDITIONS
	
	OB GET ARRAY:C1229($voResourceDefinition; "conditions"; $aoResourceConditions)
	$tableName:=OB Get:C1224($voResourceDefinition; "tableName")
	
	// MERGE THE RESOURCE CONDITIONS AND THE PARAMETER CONDITIONS
	
	For ($viCounter; 1; Size of array:C274($vpaoConditions->))
		
		APPEND TO ARRAY:C911($aoResourceConditions; $vpaoConditions->{$viCounter})
		
	End for 
	
	// LOOP THROUGH THE MERGED CONDITIONS AND BUILD QUERY LINES FOR EACH, ASSEMBLING THEM INTO ONE FINAL QUERY STRING
	
	For ($viCounter; 1; Size of array:C274($aoResourceConditions))
		
		$voCondition:=$aoResourceConditions{$viCounter}
		
		$vtBoolean:=OB Get:C1224($voCondition; "boolean")
		$vtFieldName:=OB Get:C1224($voCondition; "fieldName")
		$vtOperator:=OB Get:C1224($voCondition; "operator")
		$vtValue:=OB Get:C1224($voCondition; "value")
		
		// TRY TO GET A FIELDNUM FROM THE PROVIDED TABLENAME AND FIELDNAME
		
		If (WCR_IsField($vtResourceName; $vtFieldName))
			
			// CONVERT THE OPERATOR TO 4D OPERATOR SCRIPT
			
			If (Position:C15("not"; $vtOperator)=1)
				$vbQueryOperatorNot:=True:C214
				$vtOperator:=Replace string:C233($vtOperator; "not "; "")  // AZM 2019-08-05 ... NEED TO REMOVE THE SPACE AFTER "not"
				$vtOperator:=Replace string:C233($vtOperator; "not"; "")
			End if 
			
			Case of 
				: (($vtOperator="equals") | ($vtOperator="literal") | ($vtOperator="contains") | ($vtOperator="begins with") | ($vtOperator="ends with"))
					Case of 
						: ($vtOperator="contains")
							$vtValue:="@"+$vtValue+"@"
						: ($vtOperator="begins with")
							$vtValue:=$vtValue+"@"
						: ($vtOperator="ends with")
							$vtValue:="@"+$vtValue
					End case 
					If ($vbQueryOperatorNot=True:C214)
						$vtOperator:="#"
					Else 
						$vtOperator:="="
					End if 
				: ($vtOperator="greater than")
					$vtOperator:=">"
				: (($vtOperator="greater or equal") | ($vtOperator="greater than or equals"))
					$vtOperator:=">="
				: ($vtOperator="less than")
					$vtOperator:="<"
				: (($vtOperator="less than or equal") | ($vtOperator="less than or equals"))
					$vtOperator:="<="
				Else 
					$vtOperator:="="
			End case 
			
			// SANITIZE THE VALUE
			
			$vtValue:=SanitizeInput($vtValue; WCR_GetFieldPointer($vtResourceName; $vtFieldName))
			
			// CONVERT THE BOOLEAN TO 4D BOOLEAN SCRIPT
			
			Case of 
				: ($viCounter=1)
					$vtBoolean:=""
				: ($vtBoolean="or")
					$vtBoolean:=" |; "
				Else 
					$vtBoolean:=" &; "
			End case 
			
			// BUILD THE QUERY LINE
			
			$vtQuery:=$vtQuery+"Query(["+$tableName+"];"+$vtBoolean+"["+$tableName+"]"+$vtFieldName+$vtOperator+$vtValue+";*)"+"\r"
			
			$viCountValidConditions:=$viCountValidConditions+1
			
		Else 
			
			$vbError:=True:C214
			
		End if 
		
	End for 
	
	// IF THERE WERE NO ERRORS, AND THE WERE MORE THAN ONE VALID CONDITIONS
	
	If ($vbError=False:C215)
		
		If ($viCountValidConditions>0)
			
			// ADD FINAL CLOSING LINE TO QUERY
			
			$vtQuery:=$vtQuery+"Query(["+$tableName+"])"
			
			$vtQuery:=Replace string:C233($vtQuery; "Query"; $vtQueryModeModifier)
			
			// EXECUTE THE QUERY
			
			$vtQuery:="<!--#4DCODE\r"+$vtQuery+"\r-->"
			PROCESS 4D TAGS:C816($vtQuery; $vtDiscardedOutput)
			
		Else 
			
			ALL RECORDS:C47(WCR_GetTablePointer($vtResourceName)->)
			
		End if 
		
	End if 
	
End if 