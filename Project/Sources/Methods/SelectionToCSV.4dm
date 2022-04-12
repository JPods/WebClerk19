//%attributes = {}
// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ParseTag
//
// Description:
//
// This method will parse one jit tag and return the results.
//
// Parameters:
//
// $1 is the tag that needs to be parsed.
//
// Return:
//
// $0 is an object containing the parsed tag.
// ----------------------------------------------------

// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

// $vtReturn IS THE COMMA-DELIMITED RETURN TEXT
C_TEXT:C284($0; $vtReturnFull; $vtReturnLine)
$vtReturnFull:=""
$vtReturnLine:=""

// PARAMETER 1 IS THE TABLE NAME
C_TEXT:C284($1; $tableName)
$tableName:=$1

C_LONGINT:C283($viTableNum; $viFieldNum)
$viTableNum:=STR_GetTableNumber($tableName)

If ($viTableNum>0)
	
	C_POINTER:C301($vpTable)
	$vpTable:=Table:C252($viTableNum)
	
	// PARAMETER 2 IS THE SEMI-COLON DELIMITED LIST OF FIELDS
	C_TEXT:C284($2; $vtFieldNames)
	$vtFieldNames:=$2
	
	// $atFieldNames IS THE SPLIT LIST OF FIELD NAMES
	ARRAY TEXT:C222($atFieldNames; 0)
	GET TEXT KEYWORDS:C1141($vtFieldNames; $atFieldNames)
	
	// THE NUMBER OF RECORDS AND FIELDS WE HAVE
	C_LONGINT:C283($viFieldCount; $viRecordCount; $viFieldInc; $viRecordInc)
	$viFieldCount:=Size of array:C274($atFieldNames)
	$viRecordCount:=Records in selection:C76($vpTable->)
	
	// $vtFieldValue IS THE VALUE IN EACH FIELD
	C_TEXT:C284($vtFieldValue)
	$vtFieldValue:=""
	
	// ******************************************* //
	// ***** LOOP THROUGH SPECIFIED FIELDS ******* //
	// **** AND RECORDS ON HAND TO BUILD CSV ***** //
	// ******************************************* //
	
	// LOOP THROUGH THE FIELDS AND BUILD HEADERS
	
	For ($viFieldInc; 1; $viFieldCount)
		
		$vtReturnLine:=$vtReturnLine+","+$atFieldNames{$viFieldInc}
		
	End for 
	
	// ADD THE RETURN LINE TO THE FULL RETURN TEXT
	
	$vtReturnFull:=$vtReturnFull+Substring:C12($vtReturnLine; 2)+"\r"
	
	// LOOP THROUGH THE RECORDS
	
	FIRST RECORD:C50($vpTable->)
	
	For ($viRecordInc; 1; $viRecordCount)
		
		// RESET THE RETURN LINE
		
		$vtReturnLine:=""
		
		// LOOP THROUGH THE FIELDS AND BUILD EACH LINE
		
		For ($viFieldInc; 1; $viFieldCount)
			
			// GET THE FIELD NUM
			
			$viFieldNum:=STR_GetFieldNumber($tableName; $atFieldNames{$viFieldInc})
			
			// GET THE FIELD VALUE
			
			Case of 
					
				: ($viFieldNum>-1)  // DEFAULT CASE, IF THE FIELDNAME IS VALID
					
					$vtFieldValue:=String:C10(Field:C253($viTableNum; $viFieldNum)->)
					
					// PREPARE THE STRING VALUE FOR CSV. TO AOVID COMPLEXITY, WRAP ALL STRINGS IN DOUBLE QUOTES.
					// IF THERE ARE QUOTES IN THE WRAPPED VALUE, DOUBLE THEM ACCORDING TO CSV SPEC.
					
					$vtFieldValue:="\""+Replace string:C233($vtFieldValue; "\""; "\"\"")+"\""
					
				: ($atFieldNames{$viFieldInc}="DiscountedPrice")  // SPECIAL CASE, IF THE FIELDNAME IS NOT VALID, BUT IS A SPECIAL "FAKE" FIELDNAME
					
					ItemKeyPathVariables
					
					$vtFieldValue:=String:C10(pUnitPrice)
					
				Else   // FIELDNAME IS COMPLETLY INVALID
					
					$vtFieldValue:="Invalid FieldName"
					
			End case 
			
			// ADD VALUE TO RETURN LINE
			
			$vtReturnLine:=$vtReturnLine+","+$vtFieldValue
			
		End for 
		
		// ADD THE RETURN LINE TO THE FULL RETURN TEXT
		
		$vtReturnFull:=$vtReturnFull+Substring:C12($vtReturnLine; 2)+"\r"
		
		NEXT RECORD:C51($vpTable->)
		
	End for 
	
End if 

// RETURN THE FULL STRING

$0:=$vtReturnFull
