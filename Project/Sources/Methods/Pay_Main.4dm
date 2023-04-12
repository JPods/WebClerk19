//%attributes = {"publishedWeb":true}
//Method: Pay_Main
//adding text
C_LONGINT:C283($1)
C_REAL:C285($2; $3; $4; $limitAmt)
//TRACE
CREATE RECORD:C68([Payment:28])

[Payment:28]exchangeAmount:26:=0
If ((<>tcMONEYCHAR#strCurrency) & (strCurrency#"") & (rExchRate#1) & (rExchRate#0))
	[Payment:28]exchangeAmount:26:=pPayment
	FixNAN(->[Payment:28]exchangeAmount:26)
	$myAmount:=Round:C94(pPayment/rExchRate; <>tcDecimalTt)
	$myAvail:=Round:C94($4/rExchRate; <>tcDecimalTt)
	//pPayment:=$myAmount
Else 
	$myAmount:=pPayment
	$myAvail:=$4
End if 
[Payment:28]amount:1:=Round:C94($myAmount; <>tcDecimalTt)
If (vOrdNum#1)
	[Payment:28]idNumOrder:2:=vOrdNum
End if 
//pvCardAction
[Payment:28]idNumInvoice:3:=vInvNum
[Payment:28]customerID:4:=prntAcct
[Payment:28]salesTax:32:=vrSalesTax
[Payment:28]customerPO:33:=vsCustPONum
[Payment:28]complete:17:=False:C215
//If (([Payment]CardApproval="Pend")|([Payment]DateReceived=!01/01/01!
//))
//[Payment]DateReceived:=!01/01/01!
//Else 
[Payment:28]dateDocument:10:=pDateRcd
[Payment:28]timeReceived:52:=Current time:C178
C_DATE:C307(pDateDeposited)
[Payment:28]dateDeposit:49:=pDateDeposited
//End if 
[Payment:28]typePayment:6:=<>aPayTypes{<>aPayTypes}
[Payment:28]tenderClass:34:=<>aTndClass{<>aPayTypes}
[Payment:28]checkNum:12:=pCkNum
[Payment:28]status:46:=pvStatus
//    [Payment]Dvsn:=[Customer]InsightDivision

[Payment:28]dateExpires:14:=pDateExpire
If (pCardApprv="")
	[Payment:28]cardApproval:15:="Not Used"
Else 
	If ((pCreditCard#"") & (<>aTndClass{<>aPayTypes}=3))
		[Customer:2]creditCardNum:53:=CC_SaveData(pCreditCard)  //set fields in customer record
		[Customer:2]creditCardExpir:54:=pDateExpire
		[Customer:2]creditCardCVV:114:=pCVV
		//
		[Payment:28]creditCardNum:13:=[Customer:2]creditCardNum:53
		[Payment:28]creditCardEncode:50:=[Customer:2]creditCardEncode:112
		COPY BLOB:C558([Customer:2]creditCardBlob:117; [Payment:28]creditCardBlob:53; 0; 0; BLOB size:C605([Customer:2]creditCardBlob:117))
		[Payment:28]creditCardCVV:35:=pCVV
		[Payment:28]cardApproval:15:=pCardApprv
	End if 
End if 
[Payment:28]processorTransid:31:=pvProcessorTransID

[Payment:28]bankFrom:9:=pBank
[Payment:28]company:48:=pvCompanyPay
[Payment:28]nameOnAcct:11:=prntAttn
[Payment:28]comment:5:=pDescript
[Payment:28]exchangeRate:21:=rExchRate
[Payment:28]currency:22:=strCurrency
[Payment:28]amountAvailable:19:=$myAvail
//
[Payment:28]creditCardCVV:35:=pCVV
[Payment:28]address1:36:=pvAddress1
[Payment:28]address2:37:=pvAddress2
[Payment:28]city:38:=pvCity
[Payment:28]state:39:=pvState
[Payment:28]zip:40:=pvZip
[Payment:28]country:41:=pvCountry
[Payment:28]takenBy:47:=Current user:C182
//
If ($1=1)
	[Payment:28]history:23:=[Payment:28]history:23+("\r"*Num:C11([Payment:28]history:23#""))+"Invoice "+String:C10([Invoice:26]idNum:2; "0000-0000")+"  ---  "+String:C10(-[Payment:28]amount:1; "000,000,000.00")
Else 
	[Payment:28]history:23:=[Payment:28]history:23+"\r"+"Payment entered in Order."
End if 
[Payment:28]batchid:27:=<>viPayBatch
SAVE RECORD:C53([Payment:28])
//If (False)
//TransAct_Create ("1";0)
//End if 
Ledger_PaySave
If ($2=1)  //from Apply Pay Window
	Pay_RayInsert(1)
End if 
[Customer:2]balanceCurrent:41:=Round:C94([Customer:2]balanceCurrent:41-[Payment:28]amount:1; <>tcDecimalTt)
If ([Payment:28]amount:1>0)
	[Customer:2]lastPayDate:51:=[Payment:28]dateDocument:10
	[Customer:2]lastPayAmount:52:=[Payment:28]amount:1
End if 