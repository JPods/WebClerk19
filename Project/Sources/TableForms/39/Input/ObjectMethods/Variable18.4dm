C_LONGINT:C283(bNewRec)
C_BOOLEAN:C305(myDoNew)
TRACE:C157
If (bNewRec=1)
	srCustomer:=""
	srPhone:=""
	srZip:=""
	myDoNew:=True:C214
	FontSrchLabels(2)
	CREATE RECORD:C68([QQQVendor:38])
	srAcct:=String:C10(CounterNew(->[QQQVendor:38]); "0000000")
	[QQQVendor:38]VendorID:1:=srAcct
	[PO:39]vendorId:1:=srAcct
Else 
	If (newPo)
		FontSrchLabels(1)
	Else 
		FontSrchLabels(3)
	End if 
End if 