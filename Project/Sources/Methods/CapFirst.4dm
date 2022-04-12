//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: Function to capitalize 1st letter of each word
	VERSION_960
End if 
C_TEXT:C284($0; $1; $TempStr)
C_LONGINT:C283($i)
C_BOOLEAN:C305($NewWord)

$TempStr:=Lowercase:C14($1)
$NewWord:=True:C214
For ($i; 1; Length:C16($TempStr))  // Modified by: williamjames (111216 checked for <= length protection)
	If ($TempStr[[$i]]#" ")
		If ($NewWord)
			$TempStr[[$i]]:=Uppercase:C13($TempStr[[$i]])
			$NewWord:=False:C215
		End if 
	Else 
		$NewWord:=True:C214
	End if 
End for 
$0:=$TempStr