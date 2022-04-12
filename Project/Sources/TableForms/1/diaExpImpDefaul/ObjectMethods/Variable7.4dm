Case of 
	: (vi2<1)
		vRecDelim:=Char:C90(13)+Char:C90(10)
	: (vi2<255)
		vRecDelim:=Char:C90(vi2)
	Else 
		ALERT:C41("You must choose a valid ASCII value, less than 256.")
		vRecDelim:=Char:C90(13)
End case 