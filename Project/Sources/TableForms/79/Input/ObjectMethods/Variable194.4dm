If ([Reservation:79]customerid:3#"")
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Reservation:79]customerid:3)
	If (Records in selection:C76([Customer:2])>0)
		MODIFY SELECTION:C204([Customer:2])
		UNLOAD RECORD:C212([Customer:2])
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 