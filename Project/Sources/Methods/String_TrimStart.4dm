//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 12/18/17, 09:26:12
// ----------------------------------------------------
// Method: String_TrimSpecificChar
// Description
// 
//
// Parameters
// ----------------------------------------------------

// RETURN VARIABLE
C_TEXT:C284($0)
$0:=""

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1; $vtText)
$vtText:=$1

// PARAMETER 2 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($2; $vtTrimChar)
$vtTrimChar:=$2

// GRAB THE FIRST AND LAST CHARACTERS

C_TEXT:C284($vtFirstChar)
$vtFirstChar:=Substring:C12($vtText; 1; 1)

// CHECK TO SEE IF FIRST CHAR IS TRIMMABLE

If ($vtFirstChar=$vtTrimChar)
	$vtText:=Substring:C12($vtText; 2; (Length:C16($vtText)-1))
End if 

$0:=$vtText