Case of 
	: (b3=1)
		ACCEPT:C269
		myOK:=3
	: (b1=1)
		ACCEPT:C269
		myOK:=1
	Else 
		If ((b2=1) & (vOrdNum=0))
			ALERT:C41("Enter the PO Number.")
		Else 
			QUERY:C277([PO:39]; [PO:39]poNum:5=vOrdNum)
			If (Records in selection:C76([PO:39])=1)
				ACCEPT:C269
				myOK:=2
			Else 
				ALERT:C41("Not a valid PO Number.")
			End if 
		End if 
End case 
//Ord2POByVendor 