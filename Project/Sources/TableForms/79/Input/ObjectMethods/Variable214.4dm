If ([QQQReservation:79]ItemNum:1#"")
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[QQQReservation:79]ItemNum:1)
	If (Records in selection:C76([Item:4])>0)
		MODIFY SELECTION:C204([Item:4])
		UNLOAD RECORD:C212([Item:4])
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 