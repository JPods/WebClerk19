If (Shift down:C543)
	// ### bj ### 20200102_1506
	CONFIRM:C162("Fill in Customer Address into Order.")
	If (OK=1)
		AddressOrderFill("billtofromCustomer")
		AddressOrderFill("shiptofromCustomer")
	End if 
Else 
	DropShipFill("Order"; "Customer")
End if 