If ([Customer:2]customerID:1#<>CustAcct)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
	List_CustBuy(eItemOrd)  //last 5 invoices
End if 