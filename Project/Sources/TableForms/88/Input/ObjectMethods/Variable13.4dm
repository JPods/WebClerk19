If ([LoadTag:88]tableNum:34=(Table:C252(->[Vendor:38])))
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[LoadTag:88]customerID:23)
	ProcessTableOpen(Table:C252(->[Vendor:38])*-1)
Else 
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[LoadTag:88]customerID:23)
	ProcessTableOpen(Table:C252(->[Customer:2])*-1)
End if 