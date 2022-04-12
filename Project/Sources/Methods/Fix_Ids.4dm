//%attributes = {}
C_OBJECT:C1216($obRec; $obSel; $obRecRel; $obSelRel)
$obSel:=ds:C1482.Customer.all()
For each ($obRec; $obSel)
	$obSelRel:=ds:C1482.Order.query("customerID = :1"; $obRec.customerID)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idCustomer:=$obRec.id
		$obRecRel.save()
	End for each 
	$obSelRel:=ds:C1482.Invoice.query("customerID = :1"; $obRec.customerID)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idCustomer:=$obRec.id
		$obRecRel.save()
	End for each 
	$obSelRel:=ds:C1482.Proposal.query("customerID = :1"; $obRec.customerID)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idCustomer:=$obRec.id
		$obRecRel.save()
	End for each 
	$obSelRel:=ds:C1482.Payment.query("customerID = :1"; $obRec.customerID)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idCustomer:=$obRec.id
		$obRecRel.save()
	End for each 
	$obSelRel:=ds:C1482.Contact.query("customerID = :1"; $obRec.customerID)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idCustomer:=$obRec.id
		$obRecRel.save()
	End for each 
End for each 



$obSel:=ds:C1482.Order.all()
For each ($obRec; $obSel)
	$obSelRel:=ds:C1482.Invoice.query("orderNum = :1"; $obRec.orderNum)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idOrder:=$obRec.id
		$obRecRel.save()
	End for each 
	$obSelRel:=ds:C1482.Payment.query("orderNum = :1"; $obRec.orderNum)
	For each ($obRecRel; $obSelRel)
		$obRecRel.idOrder:=$obRec.id
		$obRecRel.save()
	End for each 
	
End for each 

