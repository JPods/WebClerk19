If (Size of array:C274(aLwItmLines)>0)
	If (vOrdNum=0)
		ALERT:C41("Enter the PO Number.")
	Else 
		QUERY:C277([PO:39]; [PO:39]poNum:5=vOrdNum)
		If (Records in selection:C76([PO:39])=1)
			myCycle:=13
			MODIFY RECORD:C57([PO:39])
		Else 
			ALERT:C41("Not a valid PO Number.")
		End if 
	End if 
Else 
	BEEP:C151
	BEEP:C151
	ALERT:C41("Select one or more items to add to the listed PO.")
End if 