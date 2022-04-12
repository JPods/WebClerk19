
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/28/16, 16:39:34
// ----------------------------------------------------
// Method: [InvoiceLine].Input.Variable1
// Description: set status to warranty
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170609_1513

QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[InvoiceLine:54]invoiceNum:1)

vtInvoiceNum:=String:C10([Invoice:26]invoiceNum:2)
vtItemNum:=[InvoiceLine:54]itemNum:4
vtLineNum:=String:C10([InvoiceLine:54]lineNum:3)
vtMessage:="Set status to Warranty for Line: "+vtLineNum+" of Invoice: "+vtInvoiceNum
CONFIRM:C162(vtmessage)
If (OK=1)
	[InvoiceLine:54]shipOrderStatus:41:="warranty"
	SAVE RECORD:C53([InvoiceLine:54])
End if 
UNLOAD RECORD:C212([Invoice:26])
