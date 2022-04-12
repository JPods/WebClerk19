//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-05T00:00:00, 10:58:30
// ----------------------------------------------------
// Method: LedgerScrub
// Description
// Modified: 09/05/17
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $custID)
C_LONGINT:C283($2; $3; $invoiceNum; $paymentNum)

CREATE SET:C116([Payment:28]; "original")
CREATE EMPTY SET:C140([Payment:28]; "myPayments")
CREATE EMPTY SET:C140([Payment:28]; "NoLedger")


If (Count parameters:C259>1)  // ignore if not passed
	$invoiceNum:=$2
	If (Count parameters:C259>2)  // ignore if not passed
		$paymentNum:=$3
	Else 
		$paymentNum:=0
	End if 
	
End if 


vi2:=Records in selection:C76([Payment:28])

For (vi1; 1; vi2)
	If (Shift down:C543)
		//vi1:=vi2
	End if 
	
	vrPercent:=Round:C94((vi1/vi2*100); 0)
	
	QUERY:C277([Ledger:30]; [Ledger:30]DocRefID:4=[Payment:28]idUnique:8; *)
	QUERY:C277([Ledger:30]; [Ledger:30]tableNum:3=28; *)
	QUERY:C277([Ledger:30])
	
	If ([Ledger:30]UnAppliedValue:6#([Payment:28]AmountAvailable:19*-1))
		ADD TO SET:C119([Payment:28]; "myPayments")
		//[Payment]UnAppliedValue := [Payment]AmountAvailable)
		//SAVE RECORD ([Payment])
	End if 
	
	If (Records in selection:C76([Ledger:30])=0)
		ADD TO SET:C119([Payment:28]; "NoLedger")
	End if 
	
	If ((vHere<2) & (vi1<vi2))
		NEXT RECORD:C51([Payment:28])
	End if 
End for 


If (vHere<2)
	UNLOAD RECORD:C212([Payment:28])
End if 

USE SET:C118("myPayments")
CLEAR SET:C117("myPayments")
If (Records in selection:C76([Payment:28])#0)
	ProcessTableOpen(Table:C252(->[Payment:28]))
Else 
	ALERT:C41("No Bad Payments")
End if 

USE SET:C118("NoLedger")
CLEAR SET:C117("NoLedger")
If (Records in selection:C76([Payment:28])#0)
	ProcessTableOpen(Table:C252(->[Payment:28]))
Else 
	ALERT:C41("No Payments Without Ledgers")
End if 

USE SET:C118("Original")
CLEAR SET:C117("Original")

UNLOAD RECORD:C212([Payment:28])
UNLOAD RECORD:C212([Payment:28])
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([QQQCustomer:2])

//script Check Invoices 20140408
//Shift Key to Exit

//Query([Invoice];[Invoice]AmountAvailable#0)

CREATE SET:C116([Invoice:26]; "original")
CREATE EMPTY SET:C140([Invoice:26]; "myInvoices")
CREATE EMPTY SET:C140([Invoice:26]; "NoLedger")

Open window:C153(100; 200; 500; 300; 5; "Progress")
ERASE WINDOW:C160
GOTO XY:C161(6; 3)

MESSAGE:C88("Starting Script Basic Loop")
If (vHere<2)
	vi2:=Records in selection:C76([Invoice:26])
	FIRST RECORD:C50([Invoice:26])
Else 
	vi2:=1
End if 

For (vi1; 1; vi2)
	If (Shift down:C543)
		//vi1:=vi2
	End if 
	
	vrPercent:=Round:C94((vi1/vi2*100); 0)
	
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88(" Record "+String:C10(vi1)+" of "+String:C10(vi2)+"  "+String:C10(vrPercent)+" %")
	
	QUERY:C277([Ledger:30]; [Ledger:30]DocRefID:4=[Invoice:26]invoiceNum:2; *)
	QUERY:C277([Ledger:30]; [Ledger:30]tableNum:3=26; *)
	QUERY:C277([Ledger:30])
	
	If ([Ledger:30]UnAppliedValue:6#([Invoice:26]balanceDue:44))
		ADD TO SET:C119([Invoice:26]; "myInvoices")
		//[Invoice]UnAppliedValue := [Invoice]AmountAvailable)
		//SAVE RECORD ([Invoice])
	End if 
	
	If (Records in selection:C76([Ledger:30])=0)
		ADD TO SET:C119([Invoice:26]; "NoLedger")
	End if 
	
	If ((vHere<2) & (vi1<vi2))
		NEXT RECORD:C51([Invoice:26])
	End if 
End for 

ERASE WINDOW:C160
GOTO XY:C161(6; 3)
MESSAGE:C88("Ending Script Basic Loop")
CLOSE WINDOW:C154

If (vHere<2)
	UNLOAD RECORD:C212([Invoice:26])
End if 

USE SET:C118("myInvoices")
CLEAR SET:C117("myInvoices")
If (Records in selection:C76([Invoice:26])#0)
	ProcessTableOpen(Table:C252(->[Invoice:26]))
Else 
	ALERT:C41("No Bad Invoices")
End if 

USE SET:C118("NoLedger")
CLEAR SET:C117("NoLedger")
If (Records in selection:C76([Invoice:26])#0)
	ProcessTableOpen(Table:C252(->[Invoice:26]))
Else 
	ALERT:C41("No Invoices Without Ledgers")
End if 

USE SET:C118("Original")
CLEAR SET:C117("Original")

UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([QQQCustomer:2])

