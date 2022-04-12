If ([QQQReservation:79]orderNum:14>0)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[QQQReservation:79]orderNum:14)
	If (Records in selection:C76([Order:3])>0)
		MODIFY SELECTION:C204([Order:3])
		UNLOAD RECORD:C212([Order:3])
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 