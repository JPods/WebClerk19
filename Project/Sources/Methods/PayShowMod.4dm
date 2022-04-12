//%attributes = {"publishedWeb":true}
If (Size of array:C274(aPayShow)>0)
	
	myCycle:=8
	jAcceptButton(False:C215; False:C215)
	
	var $tableParent; $idOrder; $idCustomer; $idInvoice : Text
	var $customer_ent; $order_ent; $invoice_ent : Object
	$tableParent:=Table name:C256(ptCurTable)
	
	GOTO SELECTED RECORD:C245([Payment:28]; aPayShow)
	
	// MustFixQQQZZZ: Bill James (2021-12-12T06:00:00Z)
	// change to automatic relations
	$customer_ent:=ds:C1482.Customer.query("customerID = :1"; [Payment:28]customerID:4)
	$order_ent:=ds:C1482.Order.query("orderNum = :1"; [Payment:28]idNumOrder:2)
	$invoice_ent:=ds:C1482.Invoice.query("invoiceNum = :1"; [Payment:28]idNumInvoice:3)
	// does this return null or empty object????
	If ($customer_ent=Null:C1517)
		$customer_ent:=New object:C1471
	End if 
	If ($order_ent=Null:C1517)
		$order_ent:=New object:C1471
	End if 
	If ($invoice_ent=Null:C1517)
		$invoice_ent:=New object:C1471
	End if 
	
	$idParent:=STR_Get_idPointer($tableParent)->
	var $idProcess : Integer
	var $new_o : Object
	
	$tableName:="Payment"
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $tableName; "task"; "by_id"; "id"; [Payment:28]id:59; \
		"tableParent"; $tableParent; "idParent"; process_o.cur.id; \
		"Customer_ent"; $customer_ent; \
		"Order_ent"; $order_ent; \
		"Invoice_ent"; $invoice_ent)
	
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Customer:2])
	UNLOAD RECORD:C212([OrderLine:49])
	REDUCE SELECTION:C351([Invoice:26]; 0)
	REDUCE SELECTION:C351([OrderLine:49]; 0)
	
	CANCEL:C270
	
	$idProcess:=New process:C317("ProcessObject"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
	
	//PayLoadShow(Records in selection([Payment]))
Else 
	BEEP:C151
End if 