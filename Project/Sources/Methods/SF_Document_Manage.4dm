//%attributes = {}

// Modified by: Bill James (2022-01-23T06:00:00Z)
// Method: SF_Document_Manage
// Description 
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		var $obData : Object
		// QQQents
		//If (False)  // move these into a customer form class
		Case of   // add more options for vendor and reps
			: (entry_o=Null:C1517)
			: (process_o.entry_o=Null:C1517)
			: (process_o.entry_o.id=Null:C1517)
				
			: (process_o.entry_o.idNumTask#Null:C1517)  // orders, invoices, proposal, po, 
				If (process_o.cur.idNumTask<9)
					$obData:=Null:C1517
				Else 
					$obData:=ds:C1482.Document.query("idNumTask = :1 "; entry_o.idNumTask)
				End if 
			: (process_o.dataClassName="Customer")
				// check out tablenum or name as a better choice
				$obData:=ds:C1482.Document.query("customerID = :1 & idNumTask < :2"; entry_o.customerID; 9)
			: (process_o.dataClassName="Item")
				$obData:=ds:C1482.Document.query("itemNum = :1 & idNumTask < :2"; entry_o.itemNum; 9)
			: (process_o.dataClassName="AdSource")
				$obData:=ds:C1482.Document.query("idForeign = :1"; entry_o.id)
				// finish this for all other
			Else 
				$obData:=Null:C1517
		End case 
		If (process_o.entsOther#Null:C1517)
			// move this to is This.relatedForms
			process_o.entsOther["Document"]:=$obData
			// $path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/Forms/Document"
			OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
		End if 
End case 