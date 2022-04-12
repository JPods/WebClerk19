//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/02/21, 23:29:28
// ----------------------------------------------------
// Method: ParseInvoiceRecord
// Description
// 
// Parameters
// ----------------------------------------------------


//  RRRR to Obje//cts
C_LONGINT:C283($1)
If ($1#[Invoice:26]invoiceNum:2)
	QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=$1)
End if 
If (Locked:C147([Invoice:26]))
	WCapi_SetParameter("isLocked"; "true")
	vResponse:="Error: Invoices record locked: "+String:C10([Invoice:26]invoiceNum:2)
Else 
	vHere:=2
	myCycle:=0
	//  $booOK:=NxPvInvAccess 
	//  NxPvInvoices
	IvcLnFillRays(1; 1)  //vLineCnt set inside procedure 
	vMod:=True:C214
	vMod:=calcInvoice(True:C214)
	vMod:=True:C214
	booAccept:=True:C214
	acceptInvoice
	
	Execute_TallyMaster("InvoicesAfterParse"; "WebScript")
End if 