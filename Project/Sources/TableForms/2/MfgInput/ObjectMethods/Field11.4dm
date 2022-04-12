If ([QQQCustomer:2]taxJuris:65="")
	[QQQCustomer:2]taxJuris:65:=Substring:C12([QQQCustomer:2]state:7; 1; 3)
End if 