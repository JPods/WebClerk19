Class extends Entity

Function newRec()->$fc_o : cs:C1710.FCEntity
	
	$fc_o:=ds:C1482.FC.new()
	$fc_o.purpose:=$purpose
	$fc_o.tableName:=$tableName
	$fc_o.securityLevel:=1
	$fc_o.obGeneral:=Init_obGeneral
	
	//If ($lbName#"")
	//$fc_o.data[$lbName]:=New object
	//$fc_o.data[$lbName].columns:=New collection
	//$fc_o.data[$lbName].entities:=New collection
	//$fc_o.data[$lbName].listbox:=New object
	//$fc_o.data[$lbName].permissions:=New object
	//End if 
	var $fieldNames : Text
	$fieldNames:=STR_GetFieldNames($tableName)
	// create views
	$fc_o.data:=New object:C1471("views"; New object:C1471("default"; \
		New object:C1471("name"; "default"; \
		"list"; New object:C1471(\
		"page"; New object:C1471; \
		"lbName"; ""; \
		"lbValues"; New object:C1471; \
		"columns"; New collection:C1472; \
		"fields"; ""); \
		"entry"; New object:C1471("fields"; ""; \
		"sfName"; ""; \
		"subform"; Null:C1517))))
	
	//$fc_o.data:=New object("views"; Null)
	//$fc_o.data.views:=New object("default"; Null)
	//$fc_o.data.views.default:=New object("name"; "default")
	
	//$fc_o.data.views.default:=New object("name"; "default"; \
						"entry"; New object("fieldList"; ""; "sfName"; ""; "subform"; Null); \
						"list"; New object(\
						"page"; New object; \
						"lbName"; ""; \
						"lbValues"; New object; \
						"columns"; New collection; \
						"fieldList"; ""))
	
	
	$fc_o.save()
	