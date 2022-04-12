If ([LoadItem:87]tableNum:1=(Table:C252(->[Vendor:38])))
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[LoadItem:87]customerID:18)
	ProcessTableOpen(Table:C252(->[Vendor:38])*-1)
Else 
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[LoadItem:87]customerID:18)
	ProcessTableOpen(Table:C252(->[Customer:2])*-1)
End if 