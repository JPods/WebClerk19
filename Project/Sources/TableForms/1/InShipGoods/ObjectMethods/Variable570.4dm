QUERY:C277([POReceipt:95]; [POReceipt:95]idUnique:1=vlReceiptID)
Case of 
	: (Records in selection:C76([POReceipt:95])=1)
		ALERT:C41("Receipt for Vendor: "+[POReceipt:95]VendorID:3)
		vrVendorInvoiceFreight:=[POReceipt:95]VendorInvoiceFreight:6
		vrVendorInvoiceAmount:=[POReceipt:95]VendorInvoiceAmount:7
		vsVendorInvoiceNum:=[POReceipt:95]VendorInvoiceNum:4
		vdVendorInvoiceDate:=[POReceipt:95]VendorInvoiceDate:5
	: (Records in selection:C76([POReceipt:95])>1)
		ALERT:C41("Multiple ReceiptIDs match: "+String:C10(vlReceiptID))
	Else 
		ALERT:C41("No ReceiptIDs match: "+String:C10(vlReceiptID))
End case 
