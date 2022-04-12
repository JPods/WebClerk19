// zzzqqq jCapitalize1st(Self:C308)
If ((OptKey#1) & (Length:C16(Self:C308->)=2))
	Self:C308->:=Uppercase:C13(Self:C308->)
End if 
If ([QQQContact:13]TaxJuris:24="")
	[QQQContact:13]TaxJuris:24:=[QQQContact:13]State:9
End if 