Case of 
	: (process_o.entry_o=Null:C1517)
	: (process_o.entry_o.id=Null:C1517)
		
	: (Form event code:C388=On Load:K2:1)
		LB_Included_ent:=ds:C1482.Payment.query("customerID = :1"; process_o.entry_o.customerID)
		
End case 