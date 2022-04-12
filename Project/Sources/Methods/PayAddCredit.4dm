//%attributes = {"publishedWeb":true}
C_REAL:C285($1)
C_LONGINT:C283($2; $3; $4)
C_TEXT:C284($5)
CREATE RECORD:C68([Payment:28])

[Payment:28]amount:1:=Round:C94($1; <>tcDecimalTt)
[Payment:28]orderNum:2:=$3  //    vOrdNum
[Payment:28]invoiceNum:3:=$4  //    vInvNum
[Payment:28]customerid:4:=$5  //    prntAcct
[Payment:28]complete:17:=False:C215
[Payment:28]dateReceived:10:=Current date:C33
[Payment:28]timeReceived:52:=Current time:C178
[Payment:28]typePayment:6:="AR Credit"
[Payment:28]checkNum:12:=""
[Payment:28]creditCardNum:13:=""
[Payment:28]dateExpires:14:=!00-00-00!
[Payment:28]cardApproval:15:=""
[Payment:28]bankFrom:9:="Credit"
[Payment:28]nameOnAcct:11:=prntAttn
[Payment:28]comment:5:="Credit equal to Dif"
//
If ($2=1)
	[Payment:28]history:23:="Credit  "+String:C10($4; "0000-0000")+"  ---  "+String:C10(-$1; "000,000,000.00")
	TransAct_Create(1; [Payment:28]amount:1; "AR_Credit")
	
	// should there be two
	TransAct_Create(1; -pDiff; "allowedDiscount")
	
	
	[Payment:28]amountAvailable:19:=0
	//[Invoice]AppliedDiscount:=Round([Invoice]AppliedDiscount+[Payments
	//]Amount;<>tcDecimalTt)
	//[Invoice]BalanceDue:=Round([Invoice]Total-[Invoice]AppliedAmount-
	//[Invoice]AppliedDiscount;<>tcDecimalTt)
	//If ([Invoice]BalanceDue=0)
	//[Invoice]DatePaid:=Current date
	//[Invoice]DaysPaid:=[Invoice]DatePaid-[Invoice]DateInvoiced
	//End if 
	//SAVE RECORD([Invoice])
Else 
	[Payment:28]history:23:="Credit entered in order."
	[Payment:28]amountAvailable:19:=[Payment:28]amount:1
End if 
SAVE RECORD:C53([Payment:28])
Ledger_PaySave