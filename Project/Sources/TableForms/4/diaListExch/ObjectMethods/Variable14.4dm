If (Self:C308->=0)
	strCurrency:=<>tcMONEYCHAR
	vRLo1:=1
Else 
	Exch_PopRate(1; ->vStr20Lo1; Self:C308; ->vRLo1)
	strCurrency:=vStr20Lo1
End if 