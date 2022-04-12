// ### bj ### 20181129_1603
// what does this do
If (False:C215)
	
	C_LONGINT:C283($i; $k; $w; $p)
	C_TEXT:C284($textAdd)
	vTextSummary:=""
	If (vText#"")
		$textAdd:=vText
		ARRAY TEXT:C222(aText1; 0)
		Repeat 
			$w:=Size of array:C274(aText1)+1
			INSERT IN ARRAY:C227(aText1; $w; 1)
			$p:=Position:C15("\r"; $textAdd)
			If ($p=0)
				aText1{$w}:=$textAdd
			Else 
				aText1{$w}:=Substring:C12($textAdd; 1; $p-1)
				$textAdd:=Substring:C12($textAdd; $p+1)
			End if 
		Until ($p=0)
	End if 
	
End if 