//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/06/14, 15:42:29
// ----------------------------------------------------
// Method: Txt_Clean
// Description
// removes all non-word characters
// word character = (a-z, A-Z, 0-9, _, and some 8-bit characters*)
// to keep spaces, tabs, or other special characters pass them in parameter 2
// to keep spaces, tabs, or other special characters in Null String pass them in parameter 3
// if there are no alphanumeric or additonal Null String characters method returns NUll STRING ""
// Parameters 2 and 3 accept regular expressions REGEX
// Parameters
// $1 Text To clean
// $2 Text String valid characters + Alphanumeric
// $3 Null String valid characters + Alphanumeric
// if $3 NOT empty valid response must contain valid characters + Alphanumeric else a NULL string is returned
// if $3 is an empty string a valid response must contain Alphanumeric or a NULL string is returned
// if a string can contain a chracter but it is invalid to have only that character
// then $3 would match $2 except for that character
// an SSN can contain a "-" but can not be just a "-" alone
// ----------------------------------------------------

C_LONGINT:C283($result; $continue)
C_TEXT:C284($1; $2; $3; $regex; $base; $valid)
// $regex is a list of character  NOT to be removed 
// parameter 2 contains characters NOT to be removed
// to keep tabs and other special characters pass them in parameter 2.

$base:="^\\w"  //NOT word charactes

If (Count parameters:C259>=2)
	$valid:=$2
	$regex:="["+$base+$valid+"]"
Else 
	$regex:="["+$base+"]"
End if 

// clean text
$1:=Preg Replace($regex; ""; $1; Regex Multi Line+Regex Ignore Case)

// trim white space at beginning
$regex:="^\\s+"
$1:=Preg Replace($regex; ""; $1; Regex Multi Line+Regex Ignore Case)

// trim white space at end
$regex:="\\s+$"
$1:=Preg Replace($regex; ""; $1; Regex Multi Line+Regex Ignore Case)

// validate text returns 1 if valid 0 if not valid
$base:="\\w"  // word / AlphaNumeric charactes
If (Count parameters:C259>=3)
	// String must have AlphaNumeric characters or valid
	$valid:=$3
	$regex:="["+$base+$valid+"]"
	$result:=Preg Match($regex; $1)
Else 
	// String must have AlphaNumeric characters
	// $result:=Preg Match ("[\\w]";$1)
	$regex:="["+$base+$valid+"]"
	$result:=Preg Match($regex; $1)
End if 


// return clean text or null string
$0:=$1*$result
