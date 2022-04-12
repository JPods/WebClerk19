//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/28/21, 07:36:13
// ----------------------------------------------------
// Method: Order_ShowOpen
// Description
// 
// Parameters
// ----------------------------------------------------

var $tableName; $vtScript; $vtAddTitle : Text
$tableName:="Order"
$vtScript:="echo_o:=ds.Order.query(\"complete < 2 \")"
$vtAddTitle:="Open Orders"
var $process_o : Object
$process_o:=New object:C1471("ents"; New object:C1471; \
"cur"; New object:C1471; \
"sel"; New object:C1471; \
"pos"; -1; \
"tableName"; $tableName; \
"tableForm"; ""; \
"form"; "OutputDS"; \
"process"; Current process:C322; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"title"; $vtAddTitle; \
"script"; $vtScript)
$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $process_o)
