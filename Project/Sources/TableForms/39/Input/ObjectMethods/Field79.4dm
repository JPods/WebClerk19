//Object Method: [PO]iPOs_9.VendorInvoice
//Noah Dykoski 991206

If ([PO:39]vendorInvoice:29#"")
	C_TEXT:C284($vendID)
	C_TEXT:C284($vendInvoice)
	$vendID:=[PO:39]vendorId:1
	$vendInvoice:=[PO:39]vendorInvoice:29
	PUSH RECORD:C176([PO:39])
	CREATE SET:C116([PO:39]; "iPOsVndInvcCheck_POs")
	
	QUERY:C277([PO:39]; [PO:39]vendorId:1=[PO:39]vendorId:1; *)
	QUERY:C277([PO:39];  & ; [PO:39]vendorInvoice:29=$vendInvoice)
	If (Records in selection:C76([PO:39])>0)
		ALERT:C41("This Vendor Invoice # appears on PO# "+String:C10([PO:39]poNum:5)+" already!")
	End if 
	USE SET:C118("iPOsVndInvcCheck_POs")
	CLEAR SET:C117("iPOsVndInvcCheck_POs")
	POP RECORD:C177([PO:39])
End if 