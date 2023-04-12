//%attributes = {}
FORM GOTO PAGE:C247(aPages)
Case of 
	: (entry_o=Null:C1517)
		BEEP:C151
	: (aPages<2)
	: (aPages{aPages}="Docs")
		var $o : Object
		$o:=New object:C1471("parentTable"; process_o.dataClassName; "idParent"; process_o.cur.id)
		OBJECT SET SUBFORM:C1138(*; "SF_Document"; [Document:100]; "Entity")
		
	: (aPages{aPages}="Q&A")
		var $o : Object
		$o:=New object:C1471("parentTable"; process_o.dataClassName; "idParent"; process_o.cur.id)
		OBJECT SET SUBFORM:C1138(*; "SF_QA"; "QA"; $o)
		
	: (aPages{aPages}="Service@")
		
	: (aPages{aPages}="Object@")
		OBJECT SET SUBFORM:C1138(*; "SF_List"; "Object")
		process_o.layoutList:="Object"
		CALL SUBFORM CONTAINER:C1086(-100)
	: (aPages{aPages}="Credit@")
		
		
End case 