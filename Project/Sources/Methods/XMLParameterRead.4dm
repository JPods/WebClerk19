//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XMLParameterRead
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_TEXT:C284($1)
C_TEXT:C284($0; $2; $workingText)
C_LONGINT:C283($p)
$0:=""
$testComplete:=False:C215
$p:=Position:C15($1+"="; $2)
If ($p>0)
	$workingText:=Substring:C12($2; $p+Length:C16($1)+1)
	If ($workingText#"")
		If ($workingText[[1]]="\"")
			$workingText:=Substring:C12($workingText; 2)
			$p:=Position:C15("\""; $workingText)
			If ($p>0)
				$0:=Substring:C12($workingText; 1; $p-1)
				$testComplete:=True:C214
			End if 
		Else 
			$p:=Position:C15(">"; $workingText)
			If ($p>0)
				$0:=Substring:C12($workingText; 1; $p-1)
			Else 
				$0:=$workingText
			End if 
		End if 
	Else 
		$0:=$workingText
		$testComplete:=True:C214
	End if 
End if 