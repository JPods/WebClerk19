//%attributes = {"publishedWeb":true}
//Procedure: HTML_ParseBody
C_TEXT:C284($1)  //html structure
C_POINTER:C301($3)  //html body, destination array element
C_TEXT:C284($2; $4)
C_LONGINT:C283($segBeg; $segEnd)
C_TEXT:C284($testText; $endDelim)
C_BOOLEAN:C305($clearSpace)
If (Count parameters:C259=4)
	$endDelim:=$4
	$clearSpace:=False:C215
Else 
	$endDelim:=" "
	$clearSpace:=True:C214
End if 
//
$segBeg:=Position:C15($1; $2)
If ($segBeg=0)
	$3->:=""
Else 
	$testText:=Substring:C12($2; $segBeg+Length:C16($1))
	$segEnd:=Position:C15($endDelim; $testText)  //;$segBeg)   need to write to another variable
	If ($segEnd=0)
		$3->:=""
		$segEnd:=Position:C15(">"; $testText)
		If ($segEnd=0)
			$3->:=""
		Else 
			$3->:=Substring:C12($testText; 1; $segEnd-1)
		End if 
	Else 
		$3->:=Substring:C12($testText; 1; $segEnd-1)
	End if 
End if 
If ($clearSpace)
	$3->:=Replace string:C233($3->; Char:C90(34); "")
	$3->:=Replace string:C233($3->; "#"; "")
End if 