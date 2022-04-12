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


C_POINTER:C301($ptUseTable)
var $1; $tableName : Text
$tableName:=$1
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
