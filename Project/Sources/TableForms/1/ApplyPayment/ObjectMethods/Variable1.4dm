C_LONGINT:C283(bdCash)
TRACE:C157
//GOTO RECORD([Invoice];aInvRecs{aInvSelRec{1}})
If (Size of array:C274(aInvSelRec)>0)
	If ((Size of array:C274(aInvRecs)>0) & (Size of array:C274(aInvRecs)>=aInvSelRec{1}))
		GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvSelRec{1}})
		QUERY:C277([DCash:62]; [DCash:62]tableApply:2=Table:C252(->[Invoice:26]); *)
		QUERY:C277([DCash:62];  & [DCash:62]docApply:3=[Invoice:26]invoiceNum:2)
		CREATE SET:C116([DCash:62]; "Current")
		QUERY:C277([DCash:62]; [DCash:62]tableReceive:8=Table:C252(->[Invoice:26]); *)
		QUERY:C277([DCash:62];  & ; [DCash:62]docReceive:4=[Invoice:26]invoiceNum:2)
		CREATE SET:C116([DCash:62]; "New")
		UNION:C120("New"; "Current"; "New")
		USE SET:C118("New")
		CLEAR SET:C117("New")
		CLEAR SET:C117("Current")
		ProcessTableOpen(Table:C252(->[DCash:62])*-1)
	End if 
End if 