//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/01/21, 11:23:06
// ----------------------------------------------------
// Method: CND_CollectionToORDA
// Description
// 
//
// Parameters
// ----------------------------------------------------



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $voORDAQuery)
$voORDAQuery:=New object:C1471()
$voORDAQuery.querySettings:=New object:C1471("parameters"; New collection:C1472())
$voORDAQuery.string:=""

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_COLLECTION:C1488($2; $vcConditions)
$vcConditions:=$2.copy()  // ENSURE THAT THE CHANGES WON'T AFFECT THE ORIGINAL COLLECTION



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viFieldType)
C_LONGINT:C283($viValueType)
C_BOOLEAN:C305($vbQueryOperatorNot)
C_TEXT:C284($vtConditionString)
C_LONGINT:C283($viCounter)


// ******************************************************************************************** //
// ** CONFIRM THAT THE RESOURCE IS VALID ****************************************************** //
// ******************************************************************************************** /

$viCounter:=1

For each ($voCondition; $vcConditions)
	
	// MAKE SURE WE HAVE A FIELD NAME AND VALUE
	
	If ((OB Is defined:C1231($voCondition; "fieldName")) & (OB Is defined:C1231($voCondition; "value")))
		
		// MAKE SURE THE FIELDNAME IS VALID
		
		If (WCR_IsField($vtResourceName; $voCondition.fieldName))
			
			// STRINGIFY THE VALUE IN SPECIAL ORDA STRING FORMAT
			
			$viFieldType:=Type:C295(WCR_GetFieldPointer($vtResourceName; $voCondition.fieldName)->)
			
			// RESET CONDITION STRING
			
			$vtConditionString:=""
			
			// PARSE THE OPERATOR
			
			$voCondition:=CND_ParseOperator($voCondition)
			
			// PARSE THE BOOLEAN
			
			$voCondition:=CND_ParseBoolean($voCondition; "ORDA")
			
			// PARSE THE VALUE
			
			$voCondition:=CND_SanitizeValue($voCondition; $viFieldType)
			
			// CONCAT THE CONDITION
			
			$vtConditionString:=$voCondition.fieldName+" "+$voCondition.operator+" :"+String:C10($viCounter)
			
			// ADD THE BOOLEAN IF NEEDED
			
			If ($viCounter>1)
				$vtConditionString:=" "+$voCondition.boolean+" "+$vtConditionString
			End if 
			
			// ADD CONDITION AND MAYBE BOOLEAN TO THE OVERALL STRING
			
			$voORDAQuery.string:=$voORDAQuery.string+$vtConditionString
			$voORDAQuery.querySettings.parameters.push($voCondition.value)
			
			// CYCLE THE COUNTER
			
			$viCounter:=$viCounter+1
			
		End if 
		
	End if 
	
End for each 

// ******************************************************************************************** //
// ** RETURN THE CONDITIONS STRING ************************************************************ //
// ******************************************************************************************** //

$0:=$voORDAQuery