If (vRLo1=0)
	vRLo1:=1
	BEEP:C151
Else 
	Case of 
		: (strCurrency="")
			BEEP:C151
		: (strCurrency=<>tcMONEYCHAR)
			doSearch:=100
		Else 
			doSearch:=200
	End case 
End if 