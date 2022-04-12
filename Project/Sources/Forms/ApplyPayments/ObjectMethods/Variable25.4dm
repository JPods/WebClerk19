C_LONGINT:C283(bdCash2)
TRACE:C157
If (aPayInvs>0)
	If ((Size of array:C274(aPayRecs)>0) & (Size of array:C274(aPayRecs)>=aPayInvs))
		GOTO RECORD:C242([Payment:28]; aPayRecs{aPayInvs})
		QUERY:C277([DCash:62]; [DCash:62]docApply:3=[Payment:28]idNum:8; *)
		QUERY:C277([DCash:62];  & [DCash:62]tableApply:2=Table:C252(->[Payment:28]))
		ProcessTableOpen(Table:C252(->[DCash:62])*-1)
	End if 
End if 