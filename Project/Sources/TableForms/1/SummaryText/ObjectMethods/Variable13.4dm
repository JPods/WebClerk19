// ### bj ### 20181129_1603
// what does this do
If (False:C215)
	C_LONGINT:C283($i; $k)
	C_TEXT:C284($textAdd)
	$k:=Size of array:C274(aText1)
	$textAdd:=""
	If ($k>0)
		For ($i; 1; $k)
			$textAdd:=$textAdd+aText1{$i}+"\r"
		End for 
		vText:=$textAdd
		//**WR INSERT TEXT (eLetterArea;$textAdd)
	End if 
End if 