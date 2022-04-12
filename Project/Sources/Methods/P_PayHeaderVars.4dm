//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/16/08, 13:18:37
// ----------------------------------------------------
// Method: P_PayHeaderVars
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
Case of 
	: ($1=1)
		vInvNum:=[Payment:28]invoiceNum:3
		vOrdNum:=[Payment:28]orderNum:2
		pvProcessorTransID:=[Payment:28]processorTransid:31
		prntAttn:=[Payment:28]nameOnAcct:11
		If ([Payment:28]invoiceNum:3>0)
			vlInvoiceNum:=[Payment:28]invoiceNum:3
		Else 
			vlInvoiceNum:=[Payment:28]orderNum:2
		End if 
		pvAddress1:=[Payment:28]address1:36
		pvCity:=[Payment:28]city:38
		pvState:=[Payment:28]state:39
		pvZip:=[Payment:28]zip:40
		vrAuthAmt:=Abs:C99([Payment:28]amount:1)
		//
		//No printing of the credit card number
		//pCreditCard:=CC_EncodeDecode (0;[Payment]CreditCardEncode)
		
		//C_Longint($cardLen)
		//$cardLen:=Length(pCreditCard)-4
		//If (<>tcCCNumStoreLast4Only=True)
		//pCreditCard:=Substring(pCreditCard;$cardLen;4)
		//pCreditCardLast4:=pCreditCard
		//Else 
		//pCreditCardLast4:=Substring(pCreditCard;$cardLen;4)
		//End if 
		vsAuthDate:=pCCDateStr
		pCVV:=[Payment:28]creditCardCVV:35
		pPayment:=[Payment:28]amount:1
		prntAcct:=[Payment:28]customerid:4
		pCreditCard:=[Payment:28]creditCardNum:13
		
		pCreditCardLast4:=pCreditCard
		
		pDateExpire:=[Payment:28]dateExpires:14
		pBank:=[Payment:28]bankFrom:9
		pCkNum:=[Payment:28]checkNum:12
		If ([Payment:28]invoiceNum:3>0)
			vlInvoiceNum:=[Payment:28]invoiceNum:3
		Else 
			vlInvoiceNum:=[Payment:28]orderNum:2
		End if 
		vrSalesTax:=[Payment:28]salesTax:32
		vsCustPONum:=[Payment:28]customerPO:33
		vscustomerID:=[Payment:28]customerid:4
		
		pvCompanyPay:=[Payment:28]company:48
		pDateDeposited:=[Payment:28]dateDeposit:49
		
	: ($1=2)
		Pay_InitializeVars
	Else 
		vInvNum:=-1
		vOrdNum:=-1
		pvProcessorTransID:=""
		prntAttn:=""
		If ([Payment:28]invoiceNum:3>0)
			vlInvoiceNum:=-1
		Else 
			vlInvoiceNum:=-1
		End if 
		pvAddress1:=""
		pvCity:=""
		pvState:=""
		pvZip:=""
		vscustomerID:=""
		vrAuthAmt:=-1
		
		pCreditCard:=""
		pCreditCardLast4:=""
		
		vsAuthDate:=""
		pCVV:=""
		vsCustPONum:=""
		pPayment:=-1
		prntAcct:=""
		pCreditCard:=""
		pDateExpire:=!00-00-00!
		pBank:=""
		pCkNum:=""
		
		vlInvoiceNum:=-1
		vrSalesTax:=-1
		pDateDeposited:=!00-00-00!
		pvCompanyPay:=""
End case 
