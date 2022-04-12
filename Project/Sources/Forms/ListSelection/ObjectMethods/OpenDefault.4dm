var $viProcess : Integer
var $new_o : Object
var $tableName : Text
$tableName:="FieldCharacteristic"

$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $tableName; \
"form"; "Input"; \
"tableForm"; process_o.tableName+"_Input"; \
"id"; process_o.ents.FieldCharacteristic.id; \
"parentProcess"; Current process:C322)
$viProcess:=New process:C317("Process_ByID"; 0; $tableName+" - "+String:C10(Count tasks:C335); $new_o)