If (bNewRec=0)
	UNLOAD RECORD:C212([QQQVendor:38])
	jSrchCustLoad(->[QQQVendor:38]; ->[QQQVendor:38]VendorID:1; ->srAcct)
	loadVendor2PO
Else 
	UniqueField(->[QQQVendor:38]; ->srAcct; ->[QQQVendor:38]VendorID:1; ->[PO:39]vendorId:1)
End if 