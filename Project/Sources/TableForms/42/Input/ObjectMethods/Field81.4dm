// zzzqqq jCapitalize1st(Self:C308)
If ((OptKey#1) & (Length:C16(Self:C308->)=2))
	Self:C308->:=Uppercase:C13(Self:C308->)
End if 
Copy_NewEntry(->[QQQCustomer:2]; ->[QQQCustomer:2]state:7; ->[Proposal:42]state:15)