var $tableName; $vtScript; $vtAddTitle : Text
$tableName:="Order"
$vtScript:=""  //  echo_o:=ds.Order.all()"
$vtAddTitle:="Orders"
var $new_o; $sel_ent : Object
$sel_ent:=ds:C1482["Order"].all()
$new_o:=New object:C1471("ents"; $sel_ent; \
"cur"; $sel_ent.first(); \
"sel"; New object:C1471; \
"pos"; -1; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"tableName"; $tableName; \
"tableForm"; ""; \
"form"; "OrderIncluded"; \
"process"; Current process:C322; \
"title"; $vtAddTitle; \
"script"; $vtScript)
$childProcess:=New process:C317("ProcessObject"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
