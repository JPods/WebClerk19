C_LONGINT:C283($i)
If (Size of array:C274(aRayLines)>0)
	TRACE:C157
	For ($i; 1; Size of array:C274(aRayLines))
		If ((aPOQtyOrder{aRayLines{$i}}>0) & (aPOUnitCost{aRayLines{$i}}>0))
			aPOExtCost{aRayLines{$i}}:=pExtPrice
			aPoDscntUP{aRayLines{$i}}:=Round:C94(aPOExtCost{aRayLines{$i}}/aPOQtyOrder{aRayLines{$i}}; <>tcDecimalUC+4)
			//aPoDscntUP{aRayLines{$i}}:=aPOExtCost{aRayLines{$i}}/aPOQtyOrder{aRayLines{$i}}  // removed rounding    // ### jwm ### 20180828_1113
			aPODiscnt{aRayLines{$i}}:=(aPOUnitCost{aRayLines{$i}}-aPoDscntUP{aRayLines{$i}})/aPOUnitCost{aRayLines{$i}}*100
			aPOExtCost{aRayLines{$i}}:=Round:C94(aPoDscntUP{aRayLines{$i}}*aPOQtyOrder{aRayLines{$i}}; <>tcDecimalTt)
			PoLnExtend(aRayLines{$i})
		End if 
	End for 
	pPricePt:="*"
	vLineMod:=True:C214
End if 