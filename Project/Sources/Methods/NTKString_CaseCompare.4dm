//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 09:00:22
// ----------------------------------------------------
// Method: NTKString_CaseCompare
// Description
// 
//
// Parameters
// ----------------------------------------------------


// (PM) String_CaseCompare
// Compares two strings in a case sensitive way
// $1 = Text 1
// $2 = Text 2
// $0 = Equal

C_TEXT:C284($1; $text1)
C_TEXT:C284($2; $text2)
C_BOOLEAN:C305($0; $equal)
C_LONGINT:C283($index)

$text1:=$1
$text2:=$2
$equal:=False:C215

// Check if the strings are of the same lengths
If (Length:C16($text1)=Length:C16($text2))
	
	// Do a character by character compare
	$equal:=True:C214
	For ($index; 1; Length:C16($text1))
		If (Character code:C91($text1[[$index]])#Character code:C91($text2[[$index]]))
			$equal:=False:C215
			$index:=Length:C16($text1)
		End if 
	End for 
	
End if 

$0:=$equal