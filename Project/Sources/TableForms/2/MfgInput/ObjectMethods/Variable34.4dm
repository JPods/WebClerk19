QUERY:C277([Item:4]; [Item:4]location:9=[Customer:2]mfrLocationid:67)
If (Records in selection:C76([Item:4])=0)
	vPartNum:="Com"+[Customer:2]customerID:1+"1"
End if 