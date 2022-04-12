Case of 
	: (Form:C1466.LB_QAQuestion_cur=Null:C1517)
		
	: (Form event code:C388=On Data Change:K2:15)
		QA_QTypeChange
		//If (Form.LB_QAQuestion_cur#Null)
		//Form.LB_QAQuestion_cur.save()
		//End if 
		
	: (Form event code:C388=On After Edit:K2:43)
		
		QA_QTypeChange
		
End case 