Case of 
	: (Form:C1466.LB_QAQuestion_cur=Null:C1517)
	: (Form event code:C388=On Data Change:K2:15)
		
		
		If (Form:C1466.LB_QAQuestion_cur#Null:C1517)
			Form:C1466.LB_QAQuestion_cur.save()
		End if 
		
		
	: (Form event code:C388=On After Edit:K2:43)
		
		If (Form:C1466.LB_QAQuestion_cur#Null:C1517)
			Form:C1466.LB_QAQuestion_cur.save()
		End if 
		
End case 