Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(ailoText16; 0)
		APPEND TO ARRAY:C911(ailoText16; "RecordPassing Commands")
		APPEND TO ARRAY:C911(ailoText16; "ItemsVirtualInventory")
		APPEND TO ARRAY:C911(ailoText16; "ItemstoVendor")
		APPEND TO ARRAY:C911(ailoText16; "ItemstoCustomer")
		APPEND TO ARRAY:C911(ailoText16; "ItemstoRep")
		APPEND TO ARRAY:C911(ailoText16; "ItemstoAlly")
		APPEND TO ARRAY:C911(ailoText16; "Project")
		APPEND TO ARRAY:C911(ailoText16; "POstoVendor")
		APPEND TO ARRAY:C911(ailoText16; "SOtoCustomerPO")
		APPEND TO ARRAY:C911(ailoText16; "SORemotetoSOInternal")
		APPEND TO ARRAY:C911(ailoText16; "SOtoPOtoVendorSO")
		APPEND TO ARRAY:C911(ailoText16; "Shipments")
		APPEND TO ARRAY:C911(ailoText16; "SpecialDiscounts")
		SORT ARRAY:C229(ailoText16)
		
		APPEND TO ARRAY:C911(ailoText16; "    ----   ")
		APPEND TO ARRAY:C911(ailoText16; "RecordPassing TechNotes")
		
		
	: (ailoText16{ailoText16}="    ----   ")
		ailoText16:=1
		
	: (ailoText16{ailoText16}="RecordPassing TechNotes")
		
		<>vTN_OutSide:="RecordPassing"
		TN_Dialog
		
	: (ailoText16>1)
		vtRPCommand:=ailoText16{ailoText16}+[SyncRelation:103]id:30
		
End case 
ailoText16:=1