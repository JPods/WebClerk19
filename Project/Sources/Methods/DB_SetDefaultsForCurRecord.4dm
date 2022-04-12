//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: DB_CreateNewRecord
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



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($vtFieldName)
C_POINTER:C301($vpField)
C_OBJECT:C1216($voFieldDefinition)
C_OBJECT:C1216($voResourceDefinition)



// ******************************************************************************************** //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, THEN UNLOAD RECORDS **************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// LOAD RESOURCE DEFINITION
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	// LOOP THROUGH THE FIELDS AND SET ALL DEFAULT VALUES
	
	For each ($vtFieldName; $voResourceDefinition.fields)
		
		$voFieldDefinition:=$voResourceDefinition.fields[$vtFieldName]
		
		If (OB Is defined:C1231($voFieldDefinition; "defaultValue"))
			
			$vpField:=WCR_GetFieldPointer($vtResourceName; $vtFieldName)
			
			// JSON TO 4D VARIABLE CAN SCREW WITH THE TYPES. DATES ARE STORED IN OBJECTS AS DATETIME STRINGS. THIS IS A
			// CASE STATEMENT RATHER THAN AN IF, SO THAT IF WE DISCOVER OTHER SPECIAL EDGE CASES IN THE FUTURE, WE CAN
			// EASILY ADD THEM.
			
			Case of 
				: (Type:C295($vpField->)=Is date:K8:7)
					$vpField->:=Date:C102($voFieldDefinition.defaultValue)
				Else 
					$vpField->:=$voFieldDefinition.defaultValue
			End case 
			
		End if 
		
	End for each 
	
End if 
