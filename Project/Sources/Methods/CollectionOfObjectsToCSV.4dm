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


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

// $vtReturn IS THE COMMA-DELIMITED RETURN TEXT
C_TEXT:C284($0; $vtDataInCSVFormat)
$vtDataInCSVFormat:=""

// PARAMETER 1 IS THE TABLE NAME
C_COLLECTION:C1488($1; $vcCollectionOfObjects)
$vcCollectionOfObjects:=$1

If (Count parameters:C259>=2)
	C_COLLECTION:C1488($2)
	$vcColumnNames:=$2
Else 
	$vcColumnNames:=COL_GetPropertyNames($vcCollectionOfObjects)
End if 


// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$vtDataInCSVFormat:=COL_ExportToCSV($vcCollectionOfObjects; $vcColumnNames)
ConsoleMessage("CollectionOfObjectsToCSV has been renamed to COL_ExportToCSV ... please update caller script.")



// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$0:=$vtDataInCSVFormat