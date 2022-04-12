//%attributes = {}

// Modified by: Bill James (2022-01-20T06:00:00Z)
// Method: DB_TableAll
// Description 
// Parameters
// ----------------------------------------------------

var $1; $tableName : Text
var $table_o : Object
$tableName:=$1
$vtScript:="All Records(["+$tableName+"])"
$vtAddTitle:=""
var $process_o : Object
$process_o:=New object:C1471("ents"; New object:C1471; \
"cur"; New object:C1471; \
"sel"; New object:C1471; \
"pos"; -1; \
"tableName"; $tableName; "tableForm"; ""; \
"form"; "OutputDS"; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"process"; Current process:C322)
$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $process_o)
