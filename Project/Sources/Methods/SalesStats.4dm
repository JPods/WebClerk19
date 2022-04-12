//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/30/20, 10:14:53
// ----------------------------------------------------
// Method: SalesStats
// Description
// 
//
// Parameters
// ----------------------------------------------------


$vdSOM:=Current date:C33-Day of:C23(Current date:C33)+1
$vdEOM:=Add to date:C393($vdSOM; 0; 1; -1)
$vdToday:=Current date:C33

// $vdSOM:=Add to date($vdSOM; -1; 0; 0)

// testing 3 years ago 
If (<>VIDEBUGMODE=333)
	$vdSOM:=Add to date:C393($vdSOM; -3; 0; 0)
	$vdEOM:=Add to date:C393($vdEOM; -3; 0; 0)
	$vdToday:=Add to date:C393($vdToday; -3; 0; 0)
End if 

C_OBJECT:C1216($obSel; $obCalc)
C_COLLECTION:C1488($coOrd)
$obSel:=ds:C1482.Order.query("dateOrdered >= :1 AND dateOrdered <= :2"; $vdSOM; $vdEOM)

vrOrdersAmountMonth:=$obSel.sum("amount")
vrOrdersTotalMonth:=$obSel.sum("total")

$obSelOrd:=ds:C1482.Order.query("dateOrdered = :1 "; $vdToday)
vrOrdersAmountToday:=$obSel.sum("amount")
vrOrdersTotalToday:=$obSel.sum("total")

$obSel:=ds:C1482.Invoice.query("dateInvoiced >= :1 AND dateInvoiced <= :2"; $vdSOM; $vdEOM)
vrInvoicesAmountMonth:=$obSel.sum("amount")
vrInvoicesTotalMonth:=$obSel.sum("total")

$obSel:=ds:C1482.Invoice.query("dateInvoiced = :1 "; $vdToday)
vrInvoicesAmountToday:=$obSel.sum("amount")
vrInvoicesTotalToday:=$obSel.sum("total")

If (False:C215)
	// works
	$coOrd:=$obSel.toCollection()
	vrOrdersAmountMonth:=$coOrd.sum("amount")
	vrOrdersTotalMonth:=$coOrd.sum("total")
	// did not work
	$obCalc:=$obSel.toObject()
	vrOrdersAmountMonth:=$obCalc.sum("amount")
	vrOrdersTotalMonth:=$obCalc.sum("total")
End if 
