//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-30T00:00:00, 14:42:25
// ----------------------------------------------------
// Method: Txt_TrimLeadingSpaces
// Description
// Modified: 06/30/13
// 
//   Trims leading and trailing spaces. If a second parameter is passed it trims that character
//
// Parameters
// ----------------------------------------------------

//  Similar
// Parse_UnWanted
// other "Txt_"

C_TEXT:C284($1; $0; $2; $unwanted)
C_LONGINT:C283($ii; $kk)
C_BOOLEAN:C305($endRead; $endWord; $nextWord)
$endRead:=False:C215
$endWord:=False:C215
$nextWord:=False:C215
$unwanted:=Char:C90(Space:K15:42)
If (Count parameters:C259>1)
	$unwanted:=$2
End if 

$kk:=Length:C16($1)
$ii:=0
Repeat   // Read to the first non-space
	$ii:=$ii+1
	If ($ii>$kk)
		$endRead:=True:C214
	Else 
		If ($1[[$ii]]#$unwanted)
			$nextWord:=True:C214
		End if 
	End if 
Until (($endRead) | ($nextWord))
$nextWord:=False:C215
If ($ii<$kk)
	$0:=Substring:C12($1; $ii)
Else 
	$0:=""
End if 

