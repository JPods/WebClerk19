//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-25T06:00:00Z)
// Method: Ledger_ThisCustomer
// Description
// Parameters
// ----------------------------------------------------

var $1; $id : Text
$id:=$1
$noConfirm:=0
var $Invoiceum; $Ledgerum; $Paymentum : Real
var $myOK : Integer

var calc_o : Object
calc_o:=New object:C1471("ents"; New object:C1471("Ledger"; New object:C1471; "Invoice"; New object:C1471; "Payment"; New object:C1471))
calc_o.ents.Ledger:=ds:C1482.Ledger.query("customerID = :1"; $id)
$Ledgerum:=calc_o.ents.Ledger.sum("unAppliedValue")

calc_o.ents.Invoice:=ds:C1482.Invoice.query("customerID = :1"; $id)
$Invoiceum:=calc_o.ents.Invoice.sum("balanceDue")

calc_o.ents.Payment:=ds:C1482.Payment.query("customerID = :1"; $id)
$Paymentum:=calc_o.ents.Payment.sum("amountAvailable")

$myOK:=1
If ($noConfirm=0)
	If ($Ledgerum=($Invoiceum-$Paymentum))
		CONFIRM:C162("Balances match, rebuild anyway?")
		$myOK:=OK
	Else 
		var $message : Text
		$message:="Rebuild deviation: "+String:C10($Invoiceum-$Paymentum-$Ledgerum)+"\r"+"Ledger: "+String:C10($Ledgerum)+"\r"+"Invoice: "+String:C10($Invoiceum)+"\r"+"Payment: "+String:C10($Paymentum)
		calc_o.defect:=New object:C1471("message"; $message; "net"; $Invoiceum-$Paymentum-$Ledgerum; "Ledger"; $Ledgerum; "Invoice"; $Invoiceum; "Payment"; $Paymentum)
		CONFIRM:C162($message)
		$myOK:=OK
	End if 
End if 
If ($myOK=1)
	calc_o.locked:=New object:C1471("Ledger"; 0; "Invoice"; 0; "Payment"; 0)
	calc_o.locked.Ledger:=DB_LockEntities(calc_o.ents.Ledger)
	calc_o.locked.Invoice:=DB_LockEntities(calc_o.ents.Invoice)
	calc_o.locked.Payment:=DB_LockEntities(calc_o.ents.Payment)
	If (calc_o.locked.Ledger+calc_o.locked.Ledger+calc_o.locked.Ledger>0)
		calc_o.error:=New object:C1471("message"; "locking error"; "Ledger"; calc_o.locked.Ledger; "Invoice"; calc_o.locked.Invoice; "Payment"; calc_o.locked.Payment)
	Else 
		
		calc_o.ents.Ledger:=calc_o.ents.Ledger.drop()  //  dk stop dropping on first error
		If (calc_o.ents.Ledger.length>0)  // should always be zero or the lock is broken
			calc_o.locked.Ledger:=calc_o.ents.Ledger
		End if 
		For each ($rec; calc_o.ents.Invoice)
			Ledger_InvSave($rec)
		End for each 
		
		For each ($rec; calc_o.ents.Payment)
			Ledger_PaySave($rec)
		End for each 
		
	End if 
End if 