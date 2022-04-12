If (([WorkOrder:66]invoiceNum:1>0) & (vHere<4))
	QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[WorkOrder:66]invoiceNum:1)
	ProcessTableOpen(Table:C252(->[Invoice:26]))
Else 
	BEEP:C151
	BEEP:C151
End if 