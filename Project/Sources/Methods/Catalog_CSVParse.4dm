//%attributes = {}

// Modified by: Bill James (2022-10-15T05:00:00Z)
// Method: Catalog_CSVParse
// Description 
// Parameters
// ----------------------------------------------------


// ----------------------------------------------------
// Method: csv2coll
// Description
// Converts CSV data to collection
// Discussion: https://forums.4d.com/Post/SP/15845771/2/16000282#15845772
// Source: https://gist.githubusercontent.com/bennadel/9753411/raw/a8e6f25f15fc78d1ef2d187e4f4864c4b528f885/code-1.htm
// This will parse a delimited string into a collection of
// collections. The default delimiter is the semicolon, but this
// can be overriden in the second argument.
// Parameters
//
// Another option: https://github.com/miyako/4d-component-csv
// ----------------------------------------------------
C_TEXT:C284($1; $csv)  // Input CSV
C_TEXT:C284($2; $strDelimiter)  // optional delimiter, default=";"
C_COLLECTION:C1488($0)  // Return

$csv:=$1

// Check to see if the delimiter is defined. If not,
// then default to semicolon.
If (Count parameters:C259>1)
	$strDelimiter:=$2
Else 
	$strDelimiter:=";"
End if 

// Create a regular expression to parse the CSV values.
C_TEXT:C284($pattern)
// Line resp. group 1: Delimiters.
// Line resp. group 2: Quoted fields.
// Line resp. group 3: Standard fields.
$pattern:="("+$strDelimiter+"|\\r?\\n|\\r|^)"+\
"(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|"+\
"([^\""+$strDelimiter+"\\r\\n]*))"

// Create an array to hold our data. Give the array
// a default empty first row.
C_COLLECTION:C1488($coll)
$coll:=New collection:C1472(New collection:C1472)

ARRAY LONGINT:C221($positions; 0)
ARRAY LONGINT:C221($lengths; 0)
C_LONGINT:C283($start)
$start:=1
// Keep looping over the regular expression matches
// until we can no longer find a match.
While (Match regex:C1019($pattern; $csv; $start; $positions; $lengths))
	
	// Get the delimiter that was found.
	C_TEXT:C284($strMatchedDelimiter)
	$strMatchedDelimiter:=Substring:C12($csv; $positions{1}; $lengths{1})
	
	// Check to see if the given delimiter has a length
	// (is not the start of string) and if it matches
	// field delimiter. If id does not, then we know
	// that this delimiter is a row delimiter.
	If ((Length:C16($strMatchedDelimiter)>0) & \
		($strMatchedDelimiter#$strDelimiter))
		
		// Since we have reached a new row of data,
		// add an empty row to our data array.
		$coll.push(New collection:C1472)
		
	End if 
	
	// Now that we have our delimiter out of the way,
	// let's check to see which kind of value we
	// captured (quoted or unquoted).
	C_TEXT:C284($strMatchedValue)
	If ($lengths{2}>0)
		
		// We found a quoted value. When we capture
		// this value, unescape any double quotes.
		$strMatchedValue:=Substring:C12($csv; $positions{2}; $lengths{2})
		$strMatchedValue:=Replace string:C233($strMatchedValue; "\"\""; "\"")
		$start:=$positions{2}+$lengths{2}
	Else 
		
		// We found a non-quoted value.
		$strMatchedValue:=Substring:C12($csv; $positions{3}; $lengths{3})
		$start:=$positions{3}+$lengths{3}
	End if 
	
	// Now that we have our value string, let's add
	// it to the data array.
	$coll[$coll.length-1].push($strMatchedValue)
	
End while 

// Return the parsed data.
$0:=$coll