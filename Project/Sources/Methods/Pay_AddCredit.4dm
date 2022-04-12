//%attributes = {"publishedWeb":true}
C_REAL:C285($1; $7; $myAmount; $myAvail)
C_LONGINT:C283($2; $3; $4)
C_TEXT:C284($5; $6; $8)
CREATE RECORD:C68([Payment:28])
[Payment:28]exchangeAmount:26:=0
Case of 
	: ($6="AR Cre@")
		[Payment:28]amount:1:=$1
		$myAmount:=$1
	: ($6="Current default file")  // ($6="Current default file")"
		[Payment:28]exchangeAmount:26:=Round:C94($1*rUExchRate; viExDisPrec)
		[Payment:28]exchangeRate:21:=rUExchRate
		[Payment:28]amount:1:=$1
		$myAmount:=0
	Else   //Diff
		If (($2#3) & (<>tcMONEYCHAR#strCurrency) & (strCurrency#"") & ($7#1) & ($7#0))  //$2#3, currency adj always base currency
			//$myAmount:=Round($1/rExchRate;<>tcDecimalTt)
			$myAmount:=Round:C94((pTotal-pPayment)/rExchRate; viExConPrec)
			[Payment:28]exchangeAmount:26:=$1
			[Payment:28]amount:1:=$myAmount
			[Payment:28]exchangeRate:21:=rExchRate
		Else 
			$myAmount:=$1
		End if 
End case 

[Payment:28]orderNum:2:=$3  //    vOrdNum
[Payment:28]invoiceNum:3:=$4  //    vInvNum
[Payment:28]customerID:4:=$5  //    prntAcct

[Payment:28]complete:17:=False:C215
If (pDateRcd#!00-00-00!)
	[Payment:28]dateReceived:10:=pDateRcd
Else 
	[Payment:28]dateReceived:10:=Current date:C33
End if   //
[Payment:28]typePayment:6:=$6
If ((rExchRate#0) | (rExchRate#1))
	[Payment:28]exchangeAmount:26:=$1
End if 
[Payment:28]checkNum:12:=""
[Payment:28]creditCardNum:13:=""
[Payment:28]dateExpires:14:=!00-00-00!
[Payment:28]cardApproval:15:=""
[Payment:28]bankFrom:9:="Credit"
[Payment:28]nameOnAcct:11:=prntAttn

[Payment:28]processorTransid:31:=pvProcessorTransID
[Payment:28]company:48:=pvCompanyPay
[Payment:28]dateDeposit:49:=pDateDeposited
[Payment:28]customerPO:33:=vsCustPONum


[Payment:28]comment:5:="Credit equal to Dif"
[Payment:28]currency:22:=$8
Case of 
	: ($2=3)
		[Payment:28]comment:5:="Currency Credit"
		[Payment:28]amountAvailable:19:=0
		[Payment:28]history:23:=[Payment:28]history:23+("\r"*Num:C11([Payment:28]history:23#""))+"Currency Credit "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+"  ---  "+String:C10([Payment:28]amount:1; "000,000,000.00")
		//TransAct_Create (1;[Payment]Amount;"Currency Credit")
	: ($2=1)  //credit in invoice
		If (Locked:C147([Invoice:26]))
			[Payment:28]amountAvailable:19:=$myAmount
		Else 
			[Payment:28]amountAvailable:19:=0
			TransAct_Create(1; -$myAmount)
		End if 
		[Payment:28]history:23:=[Payment:28]history:23+("\r"*Num:C11([Payment:28]history:23#""))+"AR Credit "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+"  ---  "+String:C10([Payment:28]amount:1; "000,000,000.00")
	Else 
		[Payment:28]history:23:=[Payment:28]history:23+("\r"*Num:C11([Payment:28]history:23#""))+"Credit entered in Order."
		[Payment:28]amountAvailable:19:=[Payment:28]amount:1
End case 
[Payment:28]batchid:27:=<>viPayBatch
[Payment:28]takenBy:47:=Current user:C182
FixNAN(->[Payment:28]exchangeAmount:26)
[Payment:28]timeReceived:52:=Current time:C178
SAVE RECORD:C53([Payment:28])
Ledger_PaySave
