//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a String Variable/Field/Constant
C_POINTER:C301($1)  //pointer to Info from a Row of a TextIO Doc
$0:=TIO_ParseString($1)
If (Not:C34(Is nil pointer:C315($0)))
	C_BOOLEAN:C305($WildExist)
	$WildExist:=False:C215
	C_TEXT:C284($InText; $Wild)
	C_LONGINT:C283($posBS; $posSQ)
	$InText:=$0->
	$0->:=""
	Repeat 
		$posBS:=Position:C15("\\"; $InText)
		If ($posBS=0)  //didn't find it
			$posBS:=32000  //bigger then $posSQ
		End if 
		$posSQ:=Position:C15("'"; $InText)
		If ($posSQ=0)  //didn't find it
			$posSQ:=32000  //bigger then $posBS
		End if 
		If (($posBS#32000) | ($posSQ#32000))
			Case of 
				: ($posBS<$posSQ)  //found Backslash before Single Quote
					Case of 
						: ($InText[[$posBS+1]]="n")
							$0->:=$0->+Substring:C12($InText; 1; $posBS-1)+"\r"
							$InText:=Substring:C12($InText; $posBS+2)
						: ($InText[[$posBS+1]]="t")
							$0->:=$0->+Substring:C12($InText; 1; $posBS-1)+"\t"
							$InText:=Substring:C12($InText; $posBS+2)
						: ($InText[[$posBS+1]]="l")
							$0->:=$0->+Substring:C12($InText; 1; $posBS-1)+"\n"
							$InText:=Substring:C12($InText; $posBS+2)
						: ($InText[[$posBS+1]]="'")
							$0->:=$0->+Substring:C12($InText; 1; $posBS-1)+"'"
							$InText:=Substring:C12($InText; $posBS+2)
						Else 
							$0->:=$0->+Substring:C12($InText; 1; $posBS)
							$InText:=Substring:C12($InText; $posBS+1)
					End case 
				Else 
					$WildExist:=True:C214
					$0->:=$0->+Substring:C12($InText; 1; $posSQ-1)
					$Wild:=Substring:C12($InText; $posSQ+1)
					$posSQ:=Position:C15("'"; $Wild)
					If ($posSQ>0)
						$InText:=Substring:C12($Wild; $posSQ+1)
						$Wild:=Substring:C12($Wild; 1; $posSQ-1)
					Else 
						$InText:=""
					End if 
					For ($index; 1; Length:C16($Wild))
						Case of 
							: ($Wild[[$index]]=<>csTIOAnyChr)  //zero or more of any chars
								$0->:=$0->+Char:C90(<>ciTIOAnyChr)
							: ($Wild[[$index]]=<>csTIO1Char)  //any single char
								$0->:=$0->+Char:C90(<>ciTIO1Char)
							: ($Wild[[$index]]=<>csTIO1Num)  //any single number: 0-9
								$0->:=$0->+Char:C90(<>ciTIO1Num)
							: ($Wild[[$index]]=<>csTIO1Alpha)  //any single letter: a-z,A-Z
								$0->:=$0->+Char:C90(<>ciTIO1Alpha)
						End case 
					End for 
			End case 
		Else 
			$0->:=$0->+$InText
		End if 
	Until ((($posBS=32000) & ($posSQ=32000)) | ($InText=""))
	If ($WildExist)
		$0->:=Char:C90(<>ciTIOMarker)+$0->
	End if 
End if 