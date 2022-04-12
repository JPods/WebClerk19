//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/16/20, 10:28:07
// ----------------------------------------------------
// Method: CND_CollectionToORDAString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtORDAQueryString)
$vtORDAQueryString:=""

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
			
			// RUN SPECIAL CORRECTIONS
			
			// DATE
			// FORMAT: ISO STRING
			// EXAMPLES: '0000-00-00' OR '' OR '2020-03-18'
			
			// TIME: 
			// FORMAT: MILLISECONDS
			// EXAMPLE: 9:43PM = '"+STRING(?21:43:00?*1000)+"'
			
			// COLLECTION
			// FORMAT: JSON ARRAY
			// EXAMPLE: ['IN','OH']
			
			Case of 
				: ($viFieldType=Is date:K8:7)
					$voCondition.value:=Date_ExportToString($voCondition.value; "ISO")
				: ($viFieldType=Is time:K8:8)
					$voCondition.value:=Time_ExportToString($voCondition.value; "MS")
				Else 
					$voCondition.value:=String:C10($voCondition.value)
			End case 
			
			// CONCAT THE CONDITION
			
			$vtConditionString:=$voCondition.fieldName+" "+$voCondition.operator+" '"+$voCondition.value+"'"
			
			// ADD THE BOOLEAN IF NEEDED
			
			If ($viCounter>1)
				$vtConditionString:=" "+$voCondition.boolean+" "+$vtConditionString
			End if 
			
			// ADD CONDITION AND MAYBE BOOLEAN TO THE OVERALL STRING
			
			$vtORDAQueryString:=$vtORDAQueryString+$vtConditionString
			
			// CYCLE THE COUNTER
			
			$viCounter:=$viCounter+1
			
		End if 
		
	End if 
	
End for each 

// ******************************************************************************************** //
// ** RETURN THE CONDITIONS STRING ************************************************************ //
// ******************************************************************************************** //

$0:=$vtORDAQueryString