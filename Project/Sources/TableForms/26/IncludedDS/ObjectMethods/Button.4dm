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
$viProcess:=New process:C317("Process_ByID"; 0; process_o.tableNameIncluded+" - "+String:C10(Count tasks:C335); $obPassable)