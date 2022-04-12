// zzzqqq jCapitalize1st(Self:C308)
If ((OptKey#1) & (Length:C16(Self:C308->)=2))
	Self:C308->:=Uppercase:C13(Self:C308->)
End if 
If (Is new record:C668([QQQCustomer:2]))
	Copy_NewEntry(->[QQQCustomer:2]; ->[QQQCustomer:2]state:7; ->[Invoice:26]state:11)
	If ([QQQCustomer:2]taxJuris:65="")
		[QQQCustomer:2]taxJuris:65:=Substring:C12([QQQCustomer:2]state:7; 1; 2)
	End if 
	If ([Invoice:26]taxJuris:33="")
		[Invoice:26]taxJuris:33:=[QQQCustomer:2]taxJuris:65
	End if 
End if 