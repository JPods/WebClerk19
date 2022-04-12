//%attributes = {"publishedWeb":true}
//Method: Ledger_CheckCustomers
C_REAL:C285($ledgerSum; $invoiceSum; $paymentSum)
C_LONGINT:C283($myOK; $i; $k)
CREATE EMPTY SET:C140([Customer:2]; "Current")
FIRST RECORD:C50([Customer:2])
$k:=Records in selection:C76([Customer:2])
//ThermoInitExit ("Check Ledgers.";$k;True)
$viProgressID:=Progress New

For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Check Ledgers")
	
	If (<>ThermoAbort)
		$i:=$k
	End if 
	QUERY:C277([Ledger:30]; [Ledger:30]customerID:1=[Customer:2]customerID:1)
	$ledgerSum:=Sum:C1([Ledger:30]unAppliedValue:6)
	QUERY:C277([Invoice:26]; [Invoice:26]balanceDue:44#0; *)
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1)
	$invoiceSum:=Sum:C1([Invoice:26]balanceDue:44)
	QUERY:C277([Payment:28]; [Payment:28]amountAvailable:19#0; *)
	QUERY:C277([Payment:28]; [Payment:28]customerID:4=[Customer:2]customerID:1)
	$paymentSum:=Sum:C1([Payment:28]amountAvailable:19)
	$myOK:=1
	If ($ledgerSum#($invoiceSum-$paymentSum))
		ADD TO SET:C119([Customer:2]; "Current")
	End if 
	NEXT RECORD:C51([Customer:2])
End for 
//Thermo_Close 
Progress QUIT($viProgressID)

If (Records in set:C195("Current")>0)
	ProcessTableOpen(2; "Current")
Else 
	ALERT:C41("There are no mismatches in totals for ledgers, payments and invoices.")
End if 
CLEAR SET:C117("Current")