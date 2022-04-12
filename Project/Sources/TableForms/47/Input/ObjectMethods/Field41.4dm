// zzzqqq jCapitalize1st(Self:C308)
If ((OptKey#1) & (Length:C16(Self:C308->)=2))
	Self:C308->:=Uppercase:C13(Self:C308->)
End if 
If ([QQQCustomer:2]taxJuris:65="")
	[QQQCustomer:2]taxJuris:65:=Substring:C12([QQQCustomer:2]state:7; 1; 3)
End if 