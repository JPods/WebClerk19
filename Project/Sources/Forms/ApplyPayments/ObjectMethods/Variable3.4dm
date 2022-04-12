TRACE:C157
Case of 
	: (Size of array:C274(aInvSelRec)=0)
		BEEP:C151
		BEEP:C151
	: (Size of array:C274(aInvSelRec)=1)
		doSearch:=11
	Else 
		CONFIRM:C162("Apply to multiple invoices?")
		If (OK=1)
			doSearch:=12
		End if 
End case 