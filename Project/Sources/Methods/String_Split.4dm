//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/15/17, 10:26:48
// ----------------------------------------------------
// Method: String_Split
// Description
// 
//
// Parameters
// ----------------------------------------------------


// (PM) String_Split
// Splits a string into an array using a delimiter
// $1 = Text
// $2 = Delimiter
// $3 = Pointer to array

C_TEXT:C284($1; $2; $text; $delimiter; $lastChar)
C_POINTER:C301($3; $array)
C_LONGINT:C283($position)
C_BOOLEAN:C305($trailingDelimiter; $returnEmptyLastSection)
$returnEmptyLastSection:=False:C215
If (Count parameters:C259>3)
	$returnEmptyLastSection:=$4
End if 

$text:=$1
$delimiter:=$2
$array:=$3

Array_SetSize(0; $array)

// CHECK TO SEE IF THE LAST CHARACTER IS THE DELIMITER
// ### jwm ### 20171212_2137 to capture empty string returned from html form,
// initial testing showed no issues but need to verify all cases

$lastChar:=Substring:C12($text; Length:C16($text); 1)
If ($lastChar=$delimiter)
	$trailingDelimiter:=True:C214
End if 


While ($text#"")
	
	$position:=Position:C15($delimiter; $text)
	If ($position>0)
		APPEND TO ARRAY:C911($array->; Substring:C12($text; 1; $position-1))  // add text up to the delimiter
		$text:=Substring:C12($text; $position+Length:C16($delimiter))
	Else 
		APPEND TO ARRAY:C911($array->; $text)
		$text:=""
	End if 
	
End while 

// Add empty string if last character was a delimiter (value submitted was empty string)
If (($trailingDelimiter=True:C214) & ($returnEmptyLastSection=True:C214))
	APPEND TO ARRAY:C911($array->; "")
End if 
