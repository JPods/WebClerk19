
Case of 
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1))
		
		
		
		$name:="Document"
		OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
		var $query_o : Object
		//$query_o:=New object("tableName"; "Customer"; "customerID"; entryEntity.customerID; "tableNum"; 2)
		$query_o:=New object:C1471("tableName"; "Customer"; "customerID"; process_o.cur.customerID; "tableNum"; 2)
		var $message_t : Text
		EXECUTE METHOD IN SUBFORM:C1085("SF_Document"; "SFEX_GetDocument"; *; $query_o)
		
		// Form.SF_Document:=Form.SF_Document
End case 

