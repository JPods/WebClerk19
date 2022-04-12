

Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		Form:C1466.invoice:=ds:C1482.Invoice.query("invoiceNum = :1"; aInvoices{aInvoices})
		// check of lock
		// lock to work on it
		GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvRecs})
		LOAD RECORD:C52([Invoice:26])
		If (Locked:C147([Invoice:26]))
			ALERT:C41("Invoice is Locked")
		End if 
		
End case 