//%attributes = {}

// Modified by: Bill James (2022-01-23T06:00:00Z)
// Method: SF_Document_Manage
// Description 
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		// QQQents
		var $o; $obData; document_o : Object
		document_o:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; 0)
		$o:=New object:C1471("parentTable"; process_o.tableName; "idParent"; process_o.cur.id)
		Case of   // add more options for vendor and reps
			: (process_o.cur.idNumTask#Null:C1517)  // orders, invoices, proposal, po, 
				If (process_o.cur.idNumTask<9)
					$obData:=Null:C1517
				Else 
					$obData:=ds:C1482.Document.query("idNumTask = :1 "; $query_o.idNumTask)
				End if 
			: (process_o.tableName="Customer")
				// check out tablenum or name as a better choice
				$obData:=ds:C1482.Document.query("customerID = :1 & idNumTask < :2"; process_o.cur.customerID; 9)
			: (process_o.tableName="Item")
				$obData:=ds:C1482.Document.query("itemNum = :1 & idNumTask < :2"; process_o.cur.itemNum; 9)
			: (process_o.tableName="AdSource")
				$obData:=ds:C1482.Document.query("idForeign = :1"; process_o.cur.id)
				// finish this for all other
			Else 
				$obData:=Null:C1517
		End case 
		document_o.data:=$obData
		$path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/Forms/Document"
		OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
		
		
		
End case 