C_LONGINT:C283($i)
//TRACE
If (Size of array:C274(aRayLines)>0)
	For ($i; 1; Size of array:C274(aRayLines))
		aPOLineAction:=aRayLines{$i}
		aPOQtyOrder{aPOLineAction}:=pQtyOrd
		If (<>vbItemBundle)
			aPOQtyOrder{aPOLineAction}:=Item_BundleCheck(aPoItemNum{aPOLineAction}; aPOQtyOrder{aPOLineAction})
		End if 
		If (pQtyOrd<0)
			PO_LnRtnValueWa(pQtyOrd; aPoUnitCost{aPOLineAction}; ->aPoItemNum{aPOLineAction})
		End if 
		PoLnExtend(aPOLineAction)
	End for 
	vLineMod:=True:C214
End if 