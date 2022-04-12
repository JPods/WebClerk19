//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 03/29/18, 14:08:42
// ----------------------------------------------------
// Method: String_ParsePhone
// Description
//
// $vtParsedPhone:=String_ParsePhone ($vtUnParsedPhone;$vtAreaCode)
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $vtParsedPhone)
$vtParsedPhone:=""

C_TEXT:C284($1; $vtUnparsedPhone)
$vtUnparsedPhone:=$1

C_TEXT:C284($2; $vtAreaCode)
$vtAreaCode:=$2

C_LONGINT:C283($viCounter; $viLengthPhone)
$viCounter:=1
$viLengthPhone:=Length:C16($vtUnparsedPhone)

// LOOP THROUGH EVERY CHARACTER IN STRING

For ($viCounter; 1; $viLengthPhone)
	
	// MAKE SURE CHARACER IS A VALID NUMBER
	
	If ((Character code:C91($1[[$viCounter]])>=48) & (Character code:C91($1[[$viCounter]])<=57))  //Must be a number
		
		$vtParsedPhone:=$vtParsedPhone+$1[[$viCounter]]
		
	End if 
	
End for 

// IF THE LENGTH OF THE STRING IS SEVEN DIGITS, PREPEND THE SPECIFIED AREA CODE

If (Length:C16($vtParsedPhone)=7)
	$vtParsedPhone:=$vtAreaCode+$vtParsedPhone
End if 

// RETURN THE PARSED PHONE

$0:=$vtParsedPhone