If ((pCardApprv#"") & (pCardApprv#"Pend@"))
	BEEP:C151
	BEEP:C151
	CONFIRM:C162("Credit card charge was approved - really Cancel??")
	If (OK=1)
		myOK:=0
		CANCEL:C270
	End if 
Else 
	myOK:=0
	CANCEL:C270
End if 