If (pUnitPrice#0)
	pDiscnt:=(pUnitPrice-pDscntPrice)/pUnitPrice*100
Else 
	pUnitPrice:=pDscntPrice
	pDiscnt:=0
End if 