//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/16/20, 10:28:07
// ----------------------------------------------------
// Method: CON_CollectionToORDAString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtQueryString)
$vtQueryString:=""

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
// ******************************************************************************************** //

// LOAD THE RESOURCE DEFINITION

$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)

// LOOP THROUGH CONDITIONS

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
			
			$voCondition:=CND_ParseBoolean($voCondition; "traditional")
			
			If ($viCounter=1)
				$voCondition.boolean:=""
			End if 
			
			// PARSE THE VALUE
			
			$voCondition:=CND_SanitizeValue($voCondition; $viFieldType)
			
			Case of 
				: (($viFieldType=Is alpha field:K8:1) | ($viFieldType=Is text:K8:3) | ($viFieldType=Is string var:K8:2))
					$voCondition.value:="\""+String:C10($voCondition.value)+"\""
				: ($viFieldType=Is date:K8:7)
					$voCondition.value:="!"+Date_ExportToString($voCondition.value; "ISO")+"!"
				: ($viFieldType=Is time:K8:8)
					$voCondition.value:="?"+Time_ExportToString($voCondition.value)+"?"
				Else 
					$voCondition.value:=String:C10($voCondition.value)
			End case 
			
			// CONCAT THE CONDITION
			
			$vtConditionString:="Query(["+$voResourceDefinition.tableName+"];"+$voCondition.boolean+"["+$voResourceDefinition.tableName+"]"+$voCondition.fieldName+$voCondition.operator+$voCondition.value+";*)"+"\r"
			
			// ADD CONDITION AND MAYBE BOOLEAN TO THE OVERALL STRING
			
			$vtQueryString:=$vtQueryString+$vtConditionString
			
			// CYCLE THE COUNTER
			
			$viCounter:=$viCounter+1
			
		End if 
		
	End if 
	
End for each 

// ******************************************************************************************** //
// ** RETURN THE CONDITIONS STRING ************************************************************ //
// ******************************************************************************************** //

$0:=$vtQueryString