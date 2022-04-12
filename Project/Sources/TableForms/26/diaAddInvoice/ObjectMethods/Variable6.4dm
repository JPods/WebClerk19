If (Records in selection:C76([Order:3])>0)
	CONFIRM:C162("Are you sure you want to create Invoices for these "+String:C10(Records in selection:C76([Order:3]))+" Order Records.")
	If (OK=1)
		myOK:=2
		CANCEL:C270
	End if 
Else 
	ALERT:C41("There are no Orders to be made-into Invoices.")
End if 