//%attributes = {"publishedWeb":true}
If (False:C215)
	// Procedure: Txt_FormatName (text) -> formatted text
	// Capitalizes the first character of each word (except words like "and" and
	//   "the") if the interprocess variable <>Format is true.  If the option key is
	//   down, then no formatting is done.  Any words found in the array named
	//   <>aWordList (obtained from the list named "Special Formatting" during
	//   startup) will be formatted exactly as they have been entered in the list.
	//   Extra spaces at the beginning or end of the string are always removed.
	
	//==2/1/96.ns 
	//  Changed Modifier key from Option to Shift, to handle capitalization by users
End if 

C_TEXT:C284($1; $0; $theText)
C_TEXT:C284($characters)
C_LONGINT:C283($i)

$theText:=$1
$characters:=".,;:/? -_+#"+Char:C90(34)  // Characters to uppercase next letter after.

If ($theText#"")
	$theText:=Txt_TrimSpaces($theText)
	//If (<>FormatText)&(Not(KeyIsDown("shift")))
	$theText:=Lowercase:C14($theText)
	// Uppercase the first letter of each word.
	If ($theText#"")
		$theText[[1]]:=Uppercase:C13($theText[[1]])
		For ($i; 1; Length:C16($theText)-1)
			If (Position:C15($theText[[$i]]; $characters)>0)
				$theText[[$i+1]]:=Uppercase:C13($theText[[$i+1]])
			End if 
		End for 
	End if 
End if 

$0:=$theText