var bInvoice : Integer
var $new_o : Object
var $titleAdder; $tableName : Text
$tableName:="Order"

var $data : Object
$data:=process_o.entsOther[$tableName]

$new_o:=New object:C1471("parentEntity"; process_o.cur; \
"ents"; $data; \
"cur"; $data.first(); \
"tableName"; $tableName; \
"tableForm"; "InputDS"; \
"form"; ""; \
"titleAdder"; $titleAdder; \
"processParent"; Current process:C322; \
"entsOther"; New object:C1471("tableName"; New object:C1471))
Customer_AddBig4($new_o)
