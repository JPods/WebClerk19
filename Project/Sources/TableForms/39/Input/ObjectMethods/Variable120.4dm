If (([PO:39]orderNum:18#0) & ([PO:39]orderNum:18#[Order:3]orderNum:2))
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[PO:39]orderNum:18)
	If (Records in selection:C76([Order:3])>0)
		MODIFY RECORD:C57([Order:3])
		NxPvPOs
	Else 
		BEEP:C151
		BEEP:C151
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 