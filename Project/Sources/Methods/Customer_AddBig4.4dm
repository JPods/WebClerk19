//%attributes = {}

// Modified by: Bill James (2022-01-26T06:00:00Z)
// Method: Customer_AddBig4
// Description
// Parameters
// ----------------------------------------------------


var $1 : Variant
var $idProcess : Integer
var $new_o : Object
If (Application type:C494#4D Server:K5:6)
	
	
	// MustFixQQQZZZ: Bill James (2021-11-20T06:00:00Z)
	// add other save functions
	
	
	$tableName:="Customer"
	$ptID:=STR_Get_idPointer($tableName)
	
	
	var bInvoice : Integer
	var $new_o : Object
	var $titleAdder; $tableName : Text
	$tableName:="Invoice"
	$new_o:=New object:C1471("parentEntity"; process_o.cur; \
		"ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"tableName"; $tableName; \
		"tableForm"; "InputDS"; \
		"form"; ""; \
		"titleAdder"; $titleAdder; \
		"processParent"; Current process:C322)
	
	
	Customer_AddBig4($new_o)
	
	
	
End if 

