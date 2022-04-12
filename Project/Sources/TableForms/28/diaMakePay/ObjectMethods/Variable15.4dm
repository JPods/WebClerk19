

// ### bj ### 20200205_1621
// changed from string to numeric in the form
KeyModifierCurrent
If (OptKey=0)
	pDiff:=Round:C94(pTotal-pPayment; <>tcDecimalTt)
End if 
If (pPayment<0)
	TRACE:C157
	$w:=Find in array:C230(<>aPayAction; "Credit")
	If ($w>0)
		<>aPayAction:=$w
	Else 
		$w:=Size of array:C274(<>aPayAction)+1
		INSERT IN ARRAY:C227(<>aPayAction; $w; 1)
		<>aPayAction{$w}:="Credit"
		<>aPayAction:=$w
	End if 
End if 
vMod:=True:C214