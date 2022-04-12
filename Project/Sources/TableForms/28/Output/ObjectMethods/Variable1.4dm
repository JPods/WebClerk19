//QUERY SELECTION([Payment];[Payment]CardApproval="Pend")
If (Records in selection:C76([Payment:28])>0)
	CONFIRM:C162("Process credit card transactions??")
	If (OK=1)
		Auth_BatchLoop
	End if 
Else 
	jAlertMessage(9201)
End if 