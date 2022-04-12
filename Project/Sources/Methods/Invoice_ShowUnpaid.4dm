//%attributes = {"publishedWeb":true}


var $tableName; $vtScript; $vtAddTitle : Text
$tableName:="Invoice"
$vtScript:="echo_o:=ds.Invoice.query(\"balanceDue # 0 \")"
$vtAddTitle:="Open Invoices"
var $new_o : Object
$new_o:=New object:C1471("ents"; New object:C1471; \
"cur"; New object:C1471; \
"sel"; New object:C1471; \
"pos"; -1; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"tableName"; $tableName; \
"tableForm"; ""; \
"form"; "OutputDS"; \
"process"; Current process:C322; \
"title"; $vtAddTitle; \
"script"; $vtScript)

$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
