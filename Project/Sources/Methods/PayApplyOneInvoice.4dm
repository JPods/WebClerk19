//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-02-07T00:00:00, 17:35:46
// ----------------------------------------------------
// Method: PayApplyOneInvoice
// Description
// Modified: 02/07/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If ([Payment:28]customerID:4=[Invoice:26]customerID:3)
	C_REAL:C285($applyAmt)
	If ([Payment:28]typePayment:6="AR Credit")
		$applyAmt:=[Payment:28]amountAvailable:19
	Else 
		TRACE:C157
		Case of 
			: (<>vbOverPayInvoice)
				$applyAmt:=[Payment:28]amountAvailable:19
			: (([Invoice:26]balanceDue:44=0) | ([Payment:28]amountAvailable:19=0))
				$applyAmt:=0
			: (([Payment:28]amountAvailable:19>[Invoice:26]balanceDue:44) & ([Invoice:26]balanceDue:44>0))
				$applyAmt:=[Invoice:26]balanceDue:44
			: (([Payment:28]amountAvailable:19<[Invoice:26]balanceDue:44) & ([Invoice:26]balanceDue:44<0))
				$applyAmt:=[Invoice:26]balanceDue:44
			Else 
				$applyAmt:=[Payment:28]amountAvailable:19
		End case 
	End if 
	If ($applyAmt#0)
		[Invoice:26]appliedAmount:46:=[Invoice:26]appliedAmount:46+$applyAmt
		[Payment:28]history:23:=[Payment:28]history:23+("\r"*Num:C11([Payment:28]history:23#""))+"Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+"  ---  "+String:C10(-$applyAmt; "000,000,000.00")
		TransAct_Create(1; -$applyAmt)
		[Invoice:26]balanceDue:44:=[Invoice:26]total:18-[Invoice:26]appliedAmount:46-[Invoice:26]appliedDiscount:45
		[Payment:28]amountAvailable:19:=[Payment:28]amountAvailable:19-$applyAmt
		[Payment:28]invoiceNum:3:=[Invoice:26]invoiceNum:2
		Ledger_InvSave
		Ledger_PaySave
		SAVE RECORD:C53([Payment:28])
		SAVE RECORD:C53([Invoice:26])
	End if 
End if 
