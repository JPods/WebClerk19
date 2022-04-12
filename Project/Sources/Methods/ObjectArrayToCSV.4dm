//%attributes = {}
// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 05/13/19, 08:37:24
// ----------------------------------------------------
// Method: ObjectArrayToCSV
//
// Description:
//
// This method will take an array of objects and build a CSV string output, using the object keys as headers, and object values as rows.
//
// Parameters:
//
// $1 is a pointer to the array of objects.
//
// Return:
//
// $0 is a string which is the comma delimited values.
// ----------------------------------------------------


// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

// $vtReturn IS THE COMMA-DELIMITED RETURN TEXT
C_TEXT:C284($0; $vtReturnFull; $vtReturnLine)
$vtReturnFull:=""
$vtReturnLine:=""

// PARAMETER 1 IS THE TABLE NAME
C_POINTER:C301($1; $vpArrayOfObjects)
$vpArrayOfObjects:=$1

// $voRow IS EACH ROW OF DATA
C_OBJECT:C1216($voRow)

C_TEXT:C284($vtValue)

C_LONGINT:C283($viCounterCol; $viCounterRow)

// $atHeaders IS THE FULL SET OF KEYS FROM THE OBJECTS IN THE ARRAY
ARRAY TEXT:C222($atHeaders; 0)
OB GET PROPERTY NAMES:C1232($vpArrayOfObjects->{1}; $atHeaders)

// ******************************************* //
// ***** LOOP THROUGH SPECIFIED FIELDS ******* //
// **** AND RECORDS ON HAND TO BUILD CSV ***** //
// ******************************************* //

// LOOP THROUGH THE OBJECT KEYS AND BUILD HEADERS

For ($viCounterCol; 1; Size of array:C274($atHeaders))
	
	$vtValue:="\""+Replace string:C233($atHeaders{$viCounterCol}; "\""; "\"\"")+"\""
	
	$vtReturnLine:=$vtReturnLine+","+$vtValue
	
End for 

// ADD THE RETURN LINE TO THE FULL RETURN TEXT

$vtReturnFull:=$vtReturnFull+Substring:C12($vtReturnLine; 2)+"\r"

// LOOP THROUGH THE ARRAY OF OBJECTS

For ($viCounterRow; 1; Size of array:C274($vpArrayOfObjects->))
	
	// RESET THE RETURN LINE AND ROW OBJECT
	
	$vtReturnLine:=""
	$voRow:=$vpArrayOfObjects->{$viCounterRow}
	
	// LOOP THROUGH THE FIELDS AND BUILD EACH LINE
	
	For ($viCounterCol; 1; Size of array:C274($atHeaders))
		
		// GET THE VALUE OUT OF THE OBJECT
		
		$vtValue:=OB Get:C1224($voRow; $atHeaders{$viCounterCol}; Is text:K8:3)
		
		// PREPARE THE STRING VALUE FOR CSV. TO AOVID COMPLEXITY, WRAP ALL STRINGS IN DOUBLE QUOTES.
		// IF THERE ARE QUOTES IN THE WRAPPED VALUE, DOUBLE THEM ACCORDING TO CSV SPEC.
		
		$vtValue:="\""+Replace string:C233($vtValue; "\""; "\"\"")+"\""
		
		// ADD THE VALUE TO THE CSV STRING
		
		$vtReturnLine:=$vtReturnLine+","+$vtValue
		
	End for 
	
	// ADD THE RETURN LINE TO THE FULL RETURN TEXT
	
	$vtReturnFull:=$vtReturnFull+Substring:C12($vtReturnLine; 2)+"\r"
	
End for 

// RETURN THE FULL STRING

$0:=$vtReturnFull
