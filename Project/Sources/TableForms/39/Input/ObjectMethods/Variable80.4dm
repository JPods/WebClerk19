If ((Size of array:C274(aPoUnitCost)>0) & (Size of array:C274(aRayLines)>0))
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274(aRayLines)
	For ($i; 1; $k)
		aPoUnitCost{aRayLines{$i}}:=pUnitPrice
		If ((pQtyShip<0) | (pQtyOrd<0))
			PO_LnRtnValueWa(pQtyShip; aPoUnitCost{aRayLines{$i}}; ->aPoItemNum{aRayLines{$i}})
		End if 
		vLineMod:=True:C214
		If (Size of array:C274(aExLnNum)>0)
			Exch_dPriceCost(->[PO:39]exchangeRate:45; ->aPoLineNum{aRayLines{$i}})
			C_LONGINT:C283($fiaLine)
			$fiaLine:=Find in array:C230(aExLnNum; aPoLineNum{aRayLines{$i}})
			If ($fiaLine>0)
				aExUnitCost{$fiaLine}:=aExUnitPrc{$fiaLine}
			End if 
		End if 
	End for 
End if 