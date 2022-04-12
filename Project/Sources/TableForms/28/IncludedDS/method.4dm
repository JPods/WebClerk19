Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_Included_ent:=ds:C1482.Payment.query("customerID = :1"; entryEntity.customerID)
		
End case 