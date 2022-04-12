If (([WorkOrder:66]idNumTask:22>0) & (vHere<4))
	QUERY:C277([Order:3]; [Order:3]idNumTask:85=[WorkOrder:66]idNumTask:22)
	If (Records in selection:C76([Order:3])=1)
		ReadOnlyReloadRecord(->[Customer:2])
		ReadOnlyReloadRecord(->[Order:3])
		ReadOnlyReloadRecord(->[OrderLine:49])
		//ReadOnlyReloadRecord (->[WorkOrderTask])
		
		ProcessTableOpen(Table:C252(->[Order:3]))
	Else 
		QUERY:C277([Proposal:42]; [Proposal:42]idNumTask:70=[WorkOrder:66]idNumTask:22)
		If (Records in selection:C76([Order:3])=1)
			ReadOnlyReloadRecord(->[Customer:2])
			ReadOnlyReloadRecord(->[Proposal:42])
			ReadOnlyReloadRecord(->[ProposalLine:43])
			//ReadOnlyReloadRecord (->[WorkOrderTask])
			
			ProcessTableOpen(Table:C252(->[Proposal:42]))
		Else 
			ALERT:C41("No matching records")
		End if 
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 