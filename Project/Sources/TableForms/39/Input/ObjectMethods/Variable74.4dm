If (bNewRec=0)
	UNLOAD RECORD:C212([QQQVendor:38])
	jSrchCustLoad(->[QQQVendor:38]; ->[QQQVendor:38]Zip:8; ->srZip)
	loadVendor2PO
Else 
	[QQQVendor:38]Zip:8:=srZip
	// Find Ship Zone ([Vendor]Zip;[Customer]Zone;[Customer]ShipVia)
	//  [Order]Zone:=[Customer]Zone
	Zip_LoadCitySt(->[QQQVendor:38]City:6; ->[QQQVendor:38]State:7; ->[QQQVendor:38]Zip:8; ->[QQQVendor:38]Country:9)
End if 