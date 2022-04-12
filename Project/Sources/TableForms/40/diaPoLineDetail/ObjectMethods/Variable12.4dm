If ((pQtyOrd#0) & (pUnitPrice#0))
	pDscntPrice:=Round:C94(pExtPrice/pQtyOrd; <>tcDecimalUP)
	pDiscnt:=(pUnitPrice-pDscntPrice)/pUnitPrice*100
	pExtPrice:=Round:C94(pDscntPrice*pQtyOrd; <>tcDecimalTt)
End if 