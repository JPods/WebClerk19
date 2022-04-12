//%attributes = {"publishedWeb":true}
[Invoice:26]weightEstimate:42:=0  //False means has been accounted for in Inventory     
[Invoice:26]packedBy:30:=Current user:C182
[Invoice:26]dateShipped:4:=Current date:C33
[Invoice:26]shipVia:5:="Manual"
[Invoice:26]terms:24:="VOID"
[Invoice:26]repID:22:="Nul"
[Invoice:26]amount:14:=0
[Invoice:26]totalCost:37:=0
[Invoice:26]salesCommission:36:=0
[Invoice:26]repCommission:28:=0
[Invoice:26]shipFreightCost:15:=0
[Invoice:26]shipMiscCosts:16:=0
[Invoice:26]shipAdjustments:17:=0
[Invoice:26]total:18:=0
[Invoice:26]salesTax:19:=0
[Invoice:26]shipTotal:20:=0
[Invoice:26]shipAdjustments:17:=0
[Invoice:26]dateLinked:31:=Current date:C33
[Invoice:26]datePaid:26:=!1901-01-01!
[Invoice:26]jrnlComplete:48:=True:C214
[Invoice:26]adSource:52:=""
$paid:=[Invoice:26]appliedAmount:46-[Invoice:26]appliedDiscount:45
If ($paid#0)
	CREATE RECORD:C68([Payment:28])
	
	[Payment:28]amount:1:=0
	[Payment:28]orderNum:2:=[Invoice:26]orderNum:1
	[Payment:28]invoiceNum:3:=[Invoice:26]invoiceNum:2
	[Payment:28]customerID:4:=[Invoice:26]customerID:3
	[Payment:28]complete:17:=False:C215
	[Payment:28]dateReceived:10:=Current date:C33
	[Payment:28]timeReceived:52:=Current time:C178
	[Payment:28]typePayment:6:="Void Invoice"
	[Payment:28]bankFrom:9:=""
	[Payment:28]nameOnAcct:11:=""
	[Payment:28]comment:5:="Void Invoice"
	[Payment:28]amountAvailable:19:=$paid
	[Payment:28]history:23:=[Payment:28]history:23+"\r"+"Void Inv "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")
	SAVE RECORD:C53([Payment:28])
	TransAct_Create(1; $paid; "voided Invoice")
	Ledger_PaySave
End if 
[Invoice:26]balanceDue:44:=0
[Invoice:26]appliedDiscount:45:=0
[Invoice:26]appliedAmount:46:=0