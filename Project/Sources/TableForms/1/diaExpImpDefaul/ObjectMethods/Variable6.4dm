If (vi2<255)
	vFldDelim:=Char:C90(vi1)
Else 
	ALERT:C41("You must choose a valid ASCII value, less than 256.")
	vFldDelim:=Char:C90(9)
End if 