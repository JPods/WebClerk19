//%attributes = {"publishedWeb":true}
// PORcpt_CreateNew
// Dan Bentson
// June 4, 2001

// 1st param = PONum
//2nd param = VendorID
//returns ReceiptID
C_LONGINT:C283($1; $PONum)
$PONum:=$1
C_TEXT:C284($2; $VendorID)
$VendorID:=$2
//
CREATE RECORD:C68([POReceipt:95])

[POReceipt:95]poNum:2:=$PONum
[POReceipt:95]VendorID:3:=$VendorID
//
C_LONGINT:C283($createdReceipt)
//$createdReceipt:=0
//While ($createdReceipt#1)
//Case of 
// : (haveReceiptID)
viPONum:=[POReceipt:95]poNum:2
vsVendorID:=[POReceipt:95]VendorID:3

//make sure to initialize these everywhere they are used.
//and everywhere a POReceipt record can be created
If (vsVendorInvoiceNum#"")
	[POReceipt:95]VendorInvoiceNum:4:=vsVendorInvoiceNum
	[POReceipt:95]VendorInvoiceDate:5:=vdVendorInvoiceDate
End if 
[POReceipt:95]VendorInvoiceFreight:6:=vrVendorInvoiceFreight
[POReceipt:95]VendorInvoiceAmount:7:=vrVendorInvoiceAmount+vrVendorInvoiceFreight

[POReceipt:95]PackingListID:12:=vsVendorPacking
[POReceipt:95]PackingListDate:13:=vdVendorPackDate
[POReceipt:95]WayBillID:17:=vdWayBill


$createdReceipt:=1
//$createdReceipt:=PORcpt_OpenEntryForm ($skipDialog)
// : ([POReceipt]ReceiptID#0)//force to accept, assigned above


//Else //by pass this dialog
//$createdReceipt:=PORcpt_OpenEntryForm 
//If ($createdReceipt#1)
//CONFIRM("Save blank Information?")
//If (OK=1)
//$createdReceipt:=1// save anyway, else loop
//End if 
//End if 
//End case 
//End while 
SAVE RECORD:C53([POReceipt:95])

$0:=[POReceipt:95]idUnique:1




