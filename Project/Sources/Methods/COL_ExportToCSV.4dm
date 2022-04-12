//%attributes = {}
// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 05/13/19, 08:37:24
// ----------------------------------------------------
// Method: COL_ExportToCSV
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


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

// $vtReturn IS THE COMMA-DELIMITED RETURN TEXT
C_TEXT:C284($0; $vtDataInCSVFormat)
$vtDataInCSVFormat:=""

// PARAMETER 1 IS THE TABLE NAME
C_COLLECTION:C1488($1; $vcCollectionOfObjects)
$vcCollectionOfObjects:=$1.map("MAP_Flatten")

If (Count parameters:C259>=2)
	C_COLLECTION:C1488($2)
	$vcColumnNames:=$2
Else 
	$vcColumnNames:=COL_GetPropertyNames($vcCollectionOfObjects)
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voRow)

C_TEXT:C284($vtColumnName)

C_COLLECTION:C1488($vcLines; $vcCells)
$vcLines:=New collection:C1472
$vcCells:=New collection:C1472



// ******************************************************************************************** //
// ** LOOP THROUGH SPECIFIED FIELDS AND RECORDS ON HAND TO BUILD CSV ************************** //
// ******************************************************************************************** //

If ($vcCollectionOfObjects.length>0)
	
	// LOOP THROUGH THE COLUMN NAMES AND ADD THEM AS A FIRST ROW
	
	$voRow:=New object:C1471()
	
	For each ($vtColumnName; $vcColumnNames)
		
		$voRow[$vtColumnName]:=$vtColumnName
		
	End for each 
	
	$vcCollectionOfObjects.insert(0; $voRow)
	
	// LOOP THROUGH THE ARRAY OF OBJECTS
	
	For each ($voRow; $vcCollectionOfObjects)
		
		// RESET THE RETURN LINE AND ROW OBJECT
		
		$vcCells:=New collection:C1472
		
		// LOOP THROUGH THE FIELDS AND BUILD EACH LINE
		
		For each ($vtColumnName; $vcColumnNames)
			
			// PREPARE THE STRING VALUE FOR CSV. TO AOVID COMPLEXITY, WRAP ALL STRINGS IN DOUBLE QUOTES.
			// IF THERE ARE QUOTES IN THE WRAPPED VALUE, DOUBLE THEM ACCORDING TO CSV SPEC.
			
			$vcCells.push(String_CSVEncode(String:C10($voRow[$vtColumnName])))
			
		End for each 
		
		// ADD THE RETURN LINE TO THE FULL RETURN TEXT
		
		$vcLines.push($vcCells.join(","))
		
	End for each 
	
End if 

// BUILD THE FULL STRING

$vtDataInCSVFormat:=$vcLines.join("\r")



// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$0:=$vtDataInCSVFormat