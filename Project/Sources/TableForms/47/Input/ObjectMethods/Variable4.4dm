C_LONGINT:C283(bContact)
If ([ItemSerial:47]contactID:30>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[ItemSerial:47]contactID:30)
	ProcessTableOpen(Table:C252(->[Contact:13])*-1)
End if 