If ((pQtyShip<0) | (pQtyOrd<0))
	pDscntPrice:=pUnitPrice
	BEEP:C151
Else 
	If (pUnitPrice#0)
		pDiscnt:=(pUnitPrice-pDscntPrice)/pUnitPrice*100
	Else 
		pUnitPrice:=pDscntPrice
		pDiscnt:=0
	End if 
End if 