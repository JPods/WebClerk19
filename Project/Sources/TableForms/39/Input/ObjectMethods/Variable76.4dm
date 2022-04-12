C_LONGINT:C283($i; $k; $cur)
If (pPartNum="*All")
	bRecByChang:=0
	$cur:=aPOLineAction
	$k:=Size of array:C274(aRayLines)
	For ($i; 1; $k)
		If (aPOQtyOrder{aRayLines{$i}}#aPOQtyRcvd{aRayLines{$i}})
			aPOLineAction:=aRayLines{$i}
			pQtyShip:=aPOQtyOrder{aPOLineAction}
			PoLineRecv
			PoLnExtend(aPOLineAction)
		End if 
	End for 
	vLineMod:=True:C214
	aPOLineAction:=$cur
	PoLnFillVar(aPOLineAction)
Else 
	//TRACE
	ListItemsLrScrn(->[PO:39]; pPartNum)
	
End if 