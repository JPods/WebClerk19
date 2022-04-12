//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/05/09, 05:55:02
// ----------------------------------------------------
// Method: Txt_FindInBetween
// Description
// Returns the text portion which is in between two delimiters
// $1 = Text to search
// $2 = Start delimiter
// $3 = Stop delimiter (optional)
// $0 = Found text

C_TEXT:C284($1; $2; $3; $0; $textToSearch; $startDelimiter; $stopDelimiter; $foundText)
C_LONGINT:C283($position1; $position2)

$textToSearch:=$1
$startDelimiter:=$2
If (Count parameters:C259>=3)
	$stopDelimiter:=$3
End if 

If ($startDelimiter="")
	$position1:=1
Else 
	$position1:=Position:C15($startDelimiter; $textToSearch)+Length:C16($startDelimiter)
End if 

If ($stopDelimiter="")
	$position2:=Length:C16($textToSearch)
Else 
	$position2:=Position:C15($stopDelimiter; Substring:C12($textToSearch; $position1+1))
End if 

$foundText:=Substring:C12($textToSearch; $position1; $position2)

$0:=$foundText
