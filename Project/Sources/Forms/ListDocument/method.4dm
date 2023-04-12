Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_Document:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1; "meta"; New object:C1471)
		//19TestFillAll(LB_Document.ents)
		Case of 
			: (process_o.dataClassName="Customer")
				LB_Document.ents:=ds:C1482.Document.query("customerID = :1"; entry_o.customerID)
				
				
				
			: ((process_o.dataClassName="Proposal") | \
				(process_o.dataClassName="Order") | \
				(process_o.dataClassName="Invoice") | \
				(process_o.dataClassName="Project"))
				LB_Document.ents:=ds:C1482.Document.query("idNumTask = :1"; entry_o.idNumTask)
				
			: (process_o.dataClassName="Vendor")
				
		End case 
		
		
		//testingqqq
		LB_Document.ents:=ds:C1482.Document.all()
		
		If (LB_Document.ents.length#Null:C1517)
			LB_Document.cur:=LB_Document.ents[0]
			LB_Document.sel:=LB_Document.ents[0]
			LB_Document.pos:=1
			OBJECT SET SCROLL POSITION:C906(*; "LB_Document"; 1)
		End if 
End case 