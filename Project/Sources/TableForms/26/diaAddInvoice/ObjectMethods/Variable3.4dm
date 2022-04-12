If (vi1#0)
	If (vi1=[Order:3]orderNum:2)
		LOAD RECORD:C52([Order:3])
		If (Locked:C147([Order:3]))
			ALERT:C41("This order is locked by another user.  An invoice may not be created.")
		Else 
			ONE RECORD SELECT:C189([Order:3])
			myOK:=1
			CANCEL:C270
		End if 
	Else 
		QUERY:C277([Order:3]; [Order:3]orderNum:2=vi1)
		If ((Records in selection:C76([Order:3])=1) & ([Order:3]completeID:83<2))
			LOAD RECORD:C52([Order:3])
			If (Locked:C147([Order:3]))
				ALERT:C41("Order "+String:C10(vi1)+" is locked by another user.  An invoice may not be created.")
			Else 
				myOK:=1
				CANCEL:C270
				vHere:=2  //was not loading the customer
				// Modified by: williamjames 100809)
			End if 
		Else 
			If (Records in selection:C76([Order:3])=0)
				ALERT:C41("Order "+String:C10(vi1)+" does not exist.")
			Else 
				ALERT:C41("Order "+String:C10(vi1)+" is complete and an Invoice may not be created.")
			End if 
		End if 
	End if 
Else 
	ALERT:C41("You must Click on an Order to create an Invoice.")
End if 