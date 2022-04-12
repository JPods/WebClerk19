var $o; $new_o : Object
var $tableName : Text
$o:=ds:C1482.Service.query("idNumOrder = :1"; process_o.cur.idNum)
If ($o.length>0)
	$tableName:="Service"
	$new_o:=New object:C1471("ents"; $o; \
		"cur"; $o.first(); \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; $tableName; \
		"tableForm"; ""; \
		"form"; "OutputDS"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"image"; New object:C1471; \
		"path"; New object:C1471; \
		"processParent"; Current process:C322)
	$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
End if 