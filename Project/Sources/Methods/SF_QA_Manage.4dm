//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		var $o : Object
		$o:=New object:C1471("parentTable"; process_o.tableName; "idParent"; process_o.cur.id)
		OBJECT SET SUBFORM:C1138(*; "SF_QA"; "QA"; $o)
End case 