QUERY:C277([ItemSerial:47]; [ItemSerial:47]invoiceNum:10=[InvoiceLine:54]invoiceNum:1)
If (Records in selection:C76([ItemSerial:47])>0)
	ProcessTableOpen(Table:C252(->[ItemSerial:47]); ""; "Serialized Items for Invoice "+String:C10([InvoiceLine:54]invoiceNum:1))
End if 