Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_QA_ent:=new
		Case of 
			: (process_o.cur.idNumTask#Null:C1517)
				LB_QA_ent:=ds:C1482.QA.query("idNumTask = :1"; process_o.cur.idNumTask)
				
			: (process_o.dataClassName="Customer")
				LB_QA_ent:=ds:C1482.QA.query("customerID = :1"; process_o.cur.customerID)
		End case 
End case 