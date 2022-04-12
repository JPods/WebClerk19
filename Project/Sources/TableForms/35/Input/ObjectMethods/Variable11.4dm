If ([AdSource:35]pOReference:31=0)
	REDUCE SELECTION:C351([PO:39]; 0)
	ADD RECORD:C56([PO:39])
	If (([PO:39]poNum:5#0) & (Record number:C243([PO:39])>-1))
		[AdSource:35]pOReference:31:=[PO:39]poNum:5
		UNLOAD RECORD:C212([PO:39])
		SAVE RECORD:C53([AdSource:35])
	End if 
Else 
	QUERY:C277([PO:39]; [PO:39]poNum:5=[AdSource:35]pOReference:31)
	If (Records in selection:C76([PO:39])=1)
		ProcessTableOpen(Table:C252(->[PO:39])*-1)
	Else 
		jAlertMessage(9201)
	End if 
End if 