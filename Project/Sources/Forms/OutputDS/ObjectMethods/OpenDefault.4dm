var $viProcess : Integer
var $new_o : Object
var $tableName : Text
$tableName:="FieldCharacteristic"
$new_o:=New object:C1471("ents"; New object:C1471; \
"cur"; New object:C1471; \
"sel"; New object:C1471; \
"pos"; -1; \
"tableName"; $tableName; \
"tableForm"; process_o.tableName+"_Input"; \
"form"; "Input"; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"process"; Current process:C322)

//  "id"; process_o.ents.FieldCharacteristic.id; \
$viProcess:=New process("Process_ByID"; 0; $tableName+" - "+String(Count tasks); $new_o)