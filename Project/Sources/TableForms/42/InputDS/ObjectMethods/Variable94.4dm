C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aPPLnSelect)
If ((Size of array:C274(aPUnitPrice)>0) & (Size of array:C274(aPPLnSelect)>0))
	For ($i; 1; $k)
		aPUnitPrice{aPPLnSelect{$i}}:=pUnitPrice
		pPricePt:="*"
		aPPricePt{aPPLnSelect{$i}}:="*"
		vLineMod:=True:C214
		If (Size of array:C274(aExLnNum)>0)
			Exch_dPriceCost(->[Proposal:42]exchangeRate:54; ->aPLineNum{aPPLnSelect{$i}})
		End if 
		PpLnExtend(aPPLnSelect{$i})
		vLineMod:=True:C214
	End for 
End if 
//