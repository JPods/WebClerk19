//%attributes = {}
Case of 
	: (aPages<2)
	: (aPages{aPages}="Docs")
		var $o : Object
		$o:=New object:C1471("parentTable"; process_o.tableName; "idParent"; process_o.cur.id)
		OBJECT SET SUBFORM:C1138(*; "SF_Document"; [Document:100]; "Entity")
		
	: (aPages{aPages}="Q&A")
		var $o : Object
		$o:=New object:C1471("parentTable"; process_o.tableName; "idParent"; process_o.cur.id)
		OBJECT SET SUBFORM:C1138(*; "SF_QA"; "QA"; $o)
		
	: (aPages{aPages}="Service@")
		
		
	: (aPages{aPages}="Credit@")
		
		
End case 