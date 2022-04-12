KeyModifierCurrent
If (OptKey=1)
	pUnitCost:=Round:C94(pUnitPrice*((100-pDiscnt)/100); <>tcDecimalUC)
	pDiscnt:=0
	If (pLocation>-1)
		pLocation:=-10
	End if 
End if 