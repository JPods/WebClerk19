

Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		If ((aidPayment>0) & (aidPayment<=Size of array:C274(aidPayment)))
			//Form.payment:=ds.Payment.query("id = :1"; aidPayment{aidPayment})
			
			GOTO RECORD:C242([Payment:28]; aPayRecs{aPayRecs})
			LOAD RECORD:C52([Payment:28])
			If (Locked:C147([Payment:28]))
				jAlertMessage(10011)
			Else 
				
			End if 
			
			
		End if 
End case 