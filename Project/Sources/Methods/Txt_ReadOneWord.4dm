//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-30T00:00:00, 15:03:33
// ----------------------------------------------------
// Method: Txt_ReadOneWord
// Description
// Modified: 06/30/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2)
C_TEXT:C284($3; $delimiter)
If (Count parameters:C259>2)
	$delimiter:=$3
Else 
	$delimiter:=" "
End if 
C_LONGINT:C283($ii; $kk)
C_BOOLEAN:C305($endRead; $endWord; $nextWord)
$endRead:=False:C215
$endWord:=False:C215
$nextWord:=False:C215

$kk:=Length:C16($1->)
$ii:=1
If ($kk>0)
	Repeat 
		If ($1->[[$ii]]#$delimiter)  // read until a space and fill into $v1
			$2->:=$2->+$1->[[$ii]]
			$ii:=$ii+1
		Else 
			$nextWord:=True:C214
		End if 
		If ($ii>$kk)  // at the end of actual text with the last character a space
			$endRead:=True:C214
		End if 
	Until (($endRead) | ($nextWord))
	If ($ii<$kk)
		$1->:=Substring:C12($1->; $ii)
	Else 
		$1->:=""
	End if 
	
End if 


