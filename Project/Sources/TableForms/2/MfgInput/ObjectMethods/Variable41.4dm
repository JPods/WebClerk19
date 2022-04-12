C_LONGINT:C283(bChangeRec)
If (bChangeRec=1)
	// zzzqqq jCapitalize1st(->srCustomer)
	[Customer:2]company:2:=srCustomer
Else 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	If (bNewRec=0)
		//    UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]company:2; ->srCustomer)
		booPreNext:=True:C214
		TRACE:C157
	Else 
		// zzzqqq jCapitalize1st(->srCustomer)
		If (myDoNew)
			$temp:=srCustomer
			Process_AddRecord("Customer")
			srCustomer:=$temp
			[Customer:2]company:2:=srCustomer
		End if 
	End if 
End if 