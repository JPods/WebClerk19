Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_Included.ents:=ds:C1482.Service.query("customerID = :1"; entryEntity.customerID)
		19TestFillAll(LB_Included.ents)
End case 