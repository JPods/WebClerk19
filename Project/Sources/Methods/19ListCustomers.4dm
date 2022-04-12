//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/06/21, 00:11:14
// ----------------------------------------------------
// Method: 19ListCustomers
// Description
// 
// Parameters
// ----------------------------------------------------


var $table_o : Object
$tableName:="Customer"
$vtScript:="All Records(["+$tableName+"])"
$vtAddTitle:=""
var $o : Object
$o:=New object:C1471("ents"; New object:C1471; \
"cur"; New object:C1471; \
"sel"; New object:C1471; \
"pos"; -1; \
"tableName"; $tableName; \
"tableForm"; ""; \
"form"; "OutputDS"; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"process"; Current process:C322)
$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $o)
