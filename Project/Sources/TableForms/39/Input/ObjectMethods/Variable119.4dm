If (bNewRec=0)
	UNLOAD RECORD:C212([Vendor:38])
	jSrchCustLoad(->[Vendor:38]; ->[Vendor:38]phone:10; ->srPhone)
	loadVendor2PO
Else 
	[Vendor:38]phone:10:=srPhone
	//  Put  the formating in the form  jFormatPhone(->[Vendor]phone; ->srPhone)
End if 