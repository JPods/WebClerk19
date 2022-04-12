If (srAcct#"")
	If (srAcct#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=srAcct)
	End if 
	If (Records in selection:C76([Customer:2])=1)
		
		ReadOnlyReloadRecord(->[Customer:2])
		ReadOnlyReloadRecord(->[Order:3])
		ReadOnlyReloadRecord(->[OrderLine:49])
		
		ProcessTableOpen(Table:C252(->[Customer:2])*-1)
	End if 
End if 