MESSAGES OFF:C175

PUSH RECORD:C176([POReceipt:95])
QUERY:C277([POReceipt:95]; [POReceipt:95]VendorID:3=vsVendorID; *)
QUERY:C277([POReceipt:95];  & ; [POReceipt:95]VendorInvoiceNum:4=vsVendorInvoiceNum)

If (Records in selection:C76([POReceipt:95])>0)
	ALERT:C41("A record already has that vendorID and vendor Invoice Number")
End if 
POP RECORD:C177([POReceipt:95])
MESSAGES ON:C181