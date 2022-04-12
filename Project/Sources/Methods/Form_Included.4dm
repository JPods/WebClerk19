//%attributes = {}
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		var $obPassable : Object
		$ent:=process_o.cur
		$obPassable:=New object:C1471("tableName"; process_o.tableNameIncluded; \
			"form"; ""; "tableForm"; \
			process_o.tableNameIncluded+"_InputDS"; \
			"ents"; LB_Included.ents; \
			"pos"; LB_Included.pos; \
			"cur"; LB_Included.cur; \
			"sel"; LB_Included.sel; \
			"page"; 1; \
			"parentProcess"; Current process:C322)
		$viProcess:=New process:C317("Process_ByID"; 0; process_o.tableName+" - "+String:C10(Count tasks:C335); $obPassable)
End case 