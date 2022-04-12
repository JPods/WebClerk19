//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/11/12, 16:10:42
// ----------------------------------------------------
// Method: PayProcessCreditCard
// Description
// 
//
// Parameters
// ----------------------------------------------------


//  >????? zzzzz check to see that successful transactions cannot be run more than once.
//

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
vscustomerID:=[Payment:28]customerID:4
If ([Payment:28]customerID:4#[Customer:2]customerID:1)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
End if 
If (([Payment:28]invoiceNum:3#0) & ([Payment:28]invoiceNum:3#[Invoice:26]invoiceNum:2))
	QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[Payment:28]invoiceNum:3)
End if 
If (([Payment:28]orderNum:2#0) & ([Payment:28]orderNum:2#[Order:3]orderNum:2))
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[Payment:28]orderNum:2)
End if 
vrAuthAmt:=Abs:C99([Payment:28]amount:1)
pCreditCard:=[Payment:28]creditCardNum:13
pCCDateStr:=Date_StrMMYY([Payment:28]dateExpires:14)
vsAuthDate:=pCCDateStr
pCVV:=[Payment:28]creditCardCVV:35
vsCustPONum:=[Payment:28]customerPO:33
C_TEXT:C284($errStr)

// Modified by: Bill James (creditcard, alert removed for greater flexibility using xml)
<>aPayTypes:=Find in array:C230(<>aPayTypes; [Payment:28]typePayment:6)
If ((<>aPayTypes>0) & (Size of array:C274(<>aTndClass)>0) & (Size of array:C274(<>aTndClass)>=<>aPayTypes))
	If ((<>aTndClass{<>aPayTypes}=<>ciTCCheck) | (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
		pPayment:=[Payment:28]amount:1
		prntAcct:=[Payment:28]customerID:4
		If (BLOB size:C605([Payment:28]creditCardBlob:53)>0)
			pCreditCard:=CC_EncodeDecode(0; ""; ->[Payment:28]creditCardBlob:53)
		End if 
		pDateExpire:=[Payment:28]dateExpires:14
		pBank:=[Payment:28]bankFrom:9
		pCkNum:=[Payment:28]checkNum:12
		If ([Payment:28]invoiceNum:3>0)
			vlInvoiceNum:=[Payment:28]invoiceNum:3
		Else 
			vlInvoiceNum:=[Payment:28]orderNum:2
		End if 
		vscustomerID:=[Payment:28]customerID:4
		vrSalesTax:=[Payment:28]salesTax:32
		vsCustPONum:=[Payment:28]customerPO:33
		prntAttn:=[Payment:28]nameOnAcct:11  // dmb 09/20/02
		pvEmail:=""
		pvPhone:=""
		If ([Invoice:26]phone:54#"")
			pvPhone:=[Invoice:26]phone:54
		Else 
			If ([Order:3]phone:67#"")
				pvPhone:=[Order:3]phone:67
			Else 
				pvPhone:=[Customer:2]phone:13
			End if 
		End if 
		If ([Invoice:26]email:76#"")
			pvEmail:=[Invoice:26]email:76
		Else 
			If ([Order:3]email:82#"")
				pvEmail:=[Order:3]email:82
			Else 
				pvEmail:=[Customer:2]email:81
			End if 
		End if 
		//
		Auth_PrepMacAth(True:C214)
		//
		Case of 
			: (viAuthStat=<>ciTASAuthed)  //1
				[Payment:28]dateReceived:10:=Current date:C33
				[Payment:28]timeReceived:52:=Current time:C178
				
				[Payment:28]cardApproval:15:=pCardApprv
				[Payment:28]referenceid:24:=pReferNum
				[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; pCreditCard; ->[Payment:28]creditCardBlob:53)
				[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum(pCreditCard)
				[Payment:28]dateExpires:14:=pDateExpire
				[Payment:28]status:46:=pvStatus
				[Payment:28]processorTransid:31:=pvProcessorTransID
				
				If (pvStatus="void")
					[Payment:28]amount:1:=0
					[Payment:28]amountAvailable:19:=0
				End if 
				
				$errStr:="Authorized "+String:C10(Current date:C33; 1)+" - "+String:C10(Current time:C178; 5)
			: (viAuthStat=<>ciTASDeclin)  //2
				$errStr:="Transaction Declined!!!"
				[Payment:28]cardApproval:15:="Fail"
			: (viAuthStat=<>ciTASPhone)
				$errStr:="Call in to bank."
				[Payment:28]cardApproval:15:="Fail"
			: (viAuthStat=<>ciTASError)
				$errStr:="Error in transaction."
				[Payment:28]cardApproval:15:="Fail"
			: (viAuthStat=<>ciTASVoided)
				$errStr:="Transaction Voided."
				[Payment:28]cardApproval:15:="Void"
			: (viAuthStat=<>ciTASOther)
				$errStr:="Error Type: Other."
				[Payment:28]cardApproval:15:="Fail"
			: (viAuthStat=<>ciTASPickUp)
				$errStr:="Pick-Up Card!!!"
				[Payment:28]cardApproval:15:="Fail"
			Else 
				$errStr:=String:C10(viAuthStat)
		End case 
		[Payment:28]history:23:="//////     "+String:C10(Current date:C33; 1)+":  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+$errStr+": "+"     //////"+"\r"+pDescript+"\r"+"//////    END    //////"+"\r"+"\r"+[Payment:28]history:23
		//If (Modified record([Payment]))
		SAVE RECORD:C53([Payment:28])
		Ledger_PaySave
		//
		If (viAuthStat#<>ciTASAuthed)
			WCErrorPageReturn
		End if 
	End if 
End if 