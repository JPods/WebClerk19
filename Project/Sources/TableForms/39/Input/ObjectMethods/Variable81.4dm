//C_Longint($i)
//If (Size of array(aRayLines)>0)
//For ($i;1;Size of array(aRayLines))
//aPoDiscnt{aRayLines{$i}}:=pDiscnt
//PoLnExtend (aRayLines{$i})
//End for 
//vLineMod:=True
//End if 

C_LONGINT:C283($i)
If (Size of array:C274(aRayLines)>0)
	KeyModifierCurrent
	If (OptKey=0)
		For ($i; 1; Size of array:C274(aRayLines))
			If ((aPOQtyOrder{aRayLines{$i}}>=0) & (aPOQtyRcvd{aRayLines{$i}}>=0))
				aPoDiscnt{aRayLines{$i}}:=pDiscnt
			Else 
				aPoDiscnt{aRayLines{$i}}:=0
			End if 
			PoLnExtend(aRayLines{$i})
		End for 
	Else 
		CONFIRM:C162("Decrease(+)/Increase(-) base cost by "+String:C10(pDiscnt; "###.0000")+"%.")
		If (OK=1)
			For ($i; 1; Size of array:C274(aRayLines))
				If ((aPOQtyOrder{aRayLines{$i}}>=0) & (aPOQtyRcvd{aRayLines{$i}}>=0))
					aPoUnitCost{aRayLines{$i}}:=DiscountApply(aPoUnitCost{aRayLines{$i}}; pDiscnt; <>tcDecimalUC)
				End if 
				aPoDiscnt{aRayLines{$i}}:=0
				PoLnExtend(aRayLines{$i})
			End for 
			pDiscnt:=0
		End if 
	End if 
	pPricePt:="*"
	vLineMod:=True:C214
End if 