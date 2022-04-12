C_OBJECT:C1216($event_o; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$event_o:=FORM Event:C1606

Case of 
	: (Form event code:C388=On Load:K2:1)
		STR_TablesListBox
	: (Form event code:C388=On Clicked:K2:4)
		var $table_o : Object
		$table_o:=Form:C1466.tableCurrent
		$tableName:=$table_o.tableName
		$vtScript:="All Records(["+$tableName+"])"
		$vtAddTitle:=""
		var $process_o : Object
		process_o:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; $tableName; \
			"tableForm"; ""; \
			"form"; "OutputDS"; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
		$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $process_o)
		
		
		//tableName:=Form.tableCurrent.tableName
		
		//STR_FieldsListBox
		
End case 