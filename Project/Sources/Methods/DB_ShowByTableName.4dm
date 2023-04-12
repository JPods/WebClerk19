//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/28/21, 08:02:43
// ----------------------------------------------------
// Method: DB_ShowByTableName
// Description
// 
// Parameters
// ----------------------------------------------------
#DECLARE($dataClassName : Text; $form : Text; $data : Object)
var $o : Object
$o:=New object:C1471("dataClassName"; ""; "form"; ""; "data"; New object:C1471; "parentProcess"; Current process:C322)

//$o:=New object("ents"; New object; \
"cur"; New object; \
"sel"; New object; \
"pos"; -1; \
"tableName"; $tableName; \
"tableForm"; ""; \
"form"; "OutputDS"; \
"entsOther"; New object("tableName"; New object); \
"process"; Current process)
$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $o)
