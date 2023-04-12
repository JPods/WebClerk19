Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_QA:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1; "meta"; New object:C1471)
		Case of 
			: (entry_o.idNumTask#Null:C1517)
				LB_QA.ents:=ds:C1482.QA.query("idNumTask = :1"; entry_o.idNumTask)
				
			: (process_o.dataClassName="Customer")
				LB_QA.ents:=ds:C1482.QA.query("customerID = :1"; entry_o.customerID)
				
			: (process_o.dataClassName="Vendor")
				LB_QA.ents:=ds:C1482.QA.query("customerID = :1"; entry_o.customerID)
				
		End case 
		//testingqqq
		//LB_QA.ents:=ds.QA.all()
		
		
		If (LB_QA.ents.length>0)
			LB_QA.cur:=LB_QA.ents[0]
			LB_QA.sel:=LB_QA.ents[0]
			LB_QA.pos:=1
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		
		
End case 

