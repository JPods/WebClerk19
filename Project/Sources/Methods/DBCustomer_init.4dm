//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/18, 12:00:44
// ----------------------------------------------------
// Method: DBCustomer_init
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($voRecord)
var $0 : Object
var $rec_o : Object
$0:=New object:C1471
$rec_o:=ds:C1482.Customer.new()
If ($rec_o.customerID="")
	$rec_o.customerID:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Customer:2]))
End if 
$rec_o.phone:=""
$rec_o.zip:=""
$rec_o.company:=""
$rec_o.dateOpened:=Current date:C33
$rec_o.terms:=Storage:C1525.default.terms
$rec_o.shipVia:=Storage:C1525.default.shipVia
$rec_o.typeSale:=Storage:C1525.default.typeSale
$rec_o.prospect:="Lead"
$rec_o.division:=Storage:C1525.default.division
$rec_o.zone:=-1
$rec_o.mfrLocationid:=0
$rec_o.country:=Storage:C1525.default.country
$rec_o.upsBillingOption:="Prepaid & Add"
$rec_o.upsInsureShipping:=True:C214
$rec_o.save()
If (process_o=Null:C1517)
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; "Customer"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"currentRecord"; $rec_o)
End if 
var $o : Object
$o:=New object:C1471("Customer"; $rec_o.id)
Storage_Replace($o; "lastEntity")
process_o.cur:=$rec_o
process_o.old:=Null:C1517
$0:=process_o.cur.toObject()
