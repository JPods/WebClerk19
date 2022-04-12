//%attributes = {"publishedWeb":true}
// Method PORcpt_OpenEntryForm
// Daniel Bentson
// May 31, 2001
// allows editing of the 4 POReceipt vendor invoice fields
// assumes there is a current record in the POReceipts table
//doesn't save the record (up to caller)
//  will destroy the selection of POReceipt Records if 
// the vendor invoice number is edited
C_LONGINT:C283($0)  //0 if user cancels, 1 if accept

//assign variables from table fields
C_LONGINT:C283(vlReceiptID; viPONum)
C_TEXT:C284(vsVendorID)
C_TEXT:C284(vsVendorInvoiceNum)
C_DATE:C307(vdVendorInvoiceDate)
C_REAL:C285(vrVendorInvoiceFreight; vrVendorInvoiceAmount)
If (Count parameters:C259=1)
	OK:=1
	$doDialog:=False:C215
	$0:=1
Else 
	$doDialog:=True:C214
	vlReceiptID:=[POReceipt:95]idUnique:1
End if 


If ($doDialog)
	viPONum:=[POReceipt:95]poNum:2
	vsVendorID:=[POReceipt:95]VendorID:3
	vsVendorInvoiceNum:=[POReceipt:95]VendorInvoiceNum:4
	vdVendorInvoiceDate:=[POReceipt:95]VendorInvoiceDate:5
	vrVendorInvoiceFreight:=[POReceipt:95]VendorInvoiceFreight:6
	vrVendorInvoiceAmount:=[POReceipt:95]VendorInvoiceAmount:7
	jCenterWindow(300; 220; 1)
	DIALOG:C40([POReceipt:95]; "diaEntryForm")
	CLOSE WINDOW:C154
	$0:=OK
	
	If ($0=1)
		// assign table fields
		[POReceipt:95]VendorInvoiceNum:4:=vsVendorInvoiceNum
		[POReceipt:95]VendorInvoiceDate:5:=vdVendorInvoiceDate
		[POReceipt:95]VendorInvoiceFreight:6:=vrVendorInvoiceFreight
		[POReceipt:95]VendorInvoiceAmount:7:=vrVendorInvoiceAmount
	End if 
End if 