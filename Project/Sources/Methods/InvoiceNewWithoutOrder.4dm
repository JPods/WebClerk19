//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-06T00:00:00, 04:41:36
// ----------------------------------------------------
// Method: InvoiceNewNoOrder
// Description
// Modified: 11/06/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If ([Invoice:26]invoiceNum:2=0)
	[Invoice:26]invoiceNum:2:=CounterNew(->[Invoice:26])
End if 
[Invoice:26]orderNum:1:=1
[Invoice:26]autoFreight:32:=(<>tcAutoFrght=1)
[Invoice:26]fob:39:=Storage:C1525.default.fob
[Invoice:26]siteID:86:=DSGetMachineSiteID
vsiteID:=[Invoice:26]siteID:86
[Invoice:26]dateShipped:4:=Current date:C33
[Invoice:26]packedBy:30:=Current user:C182
$0:=True:C214
viInvcLnCnt:=0
Case of 
	: ([Invoice:26]customerID:3#"")
		// customer record already assigned by 
	: (<>LoadCustomerRecord>-1)
		If (<>LoadCustomerRecord#Record number:C243([Customer:2]))
			GOTO RECORD:C242([Customer:2]; <>LoadCustomerRecord)
		End if 
		ENABLE MENU ITEM:C149(5; 5)
	: ((vHere<=2) & (ptCurTable=(->[Invoice:26])))
		GOTO RECORD:C242([Customer:2]; <>overTheCntr)
		ENABLE MENU ITEM:C149(5; 5)
	: ((vHere>=2) & (Record number:C243([Customer:2])=-1))
		GOTO RECORD:C242([Customer:2]; <>overTheCntr)
		ENABLE MENU ITEM:C149(5; 5)
End case 
LoadCustomersInvoices  //   vIvcDirect:=False  