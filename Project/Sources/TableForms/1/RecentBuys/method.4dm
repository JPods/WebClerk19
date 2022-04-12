Case of 
	: (Before:C29)
		Item_ListBe4(eItemOrd)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
		List_CustBuy(eItemOrd)  //last 5 invoices 
		
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	Else 
		
		If ([Customer:2]customerID:1#<>CustAcct)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
			List_CustBuy(eItemOrd)  //last 5 invoices
		End if 
End case 