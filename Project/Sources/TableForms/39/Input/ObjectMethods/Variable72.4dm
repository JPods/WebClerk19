If (bNewRec=0)
	//  UNLOAD RECORD([Vendor])
	jSrchCustLoad(->[QQQVendor:38]; ->[QQQVendor:38]Company:2; ->srCustomer)
	loadVendor2PO
Else 
	// zzzqqq jCapitalize1st(->srCustomer)
	[PO:39]vendorCompany:39:=srCustomer
	[QQQVendor:38]Company:2:=srCustomer
End if 