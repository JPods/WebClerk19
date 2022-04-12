// zzzqqq jCapitalize1st(Self:C308)
If (([QQQCustomer:2]individual:72) & ([QQQCustomer:2]company:2=""))
	[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+", "+[QQQCustomer:2]nameFirst:73
	srCustomer:=[QQQCustomer:2]company:2
End if 