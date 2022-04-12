C_LONGINT:C283($i)
If (Size of array:C274(aRayLines)>0)
	TRACE:C157
	For ($i; 1; Size of array:C274(aRayLines))
		If (aOQtyOrder{aRayLines{$i}}>0)
			If (aOUnitPrice{aRayLines{$i}}<=0)
				If (pExtPrice>0)
					aOUnitPrice{aRayLines{$i}}:=Round:C94(pExtPrice/aOQtyOrder{aRayLines{$i}}; <>tcDecimalUP+3)
					pUnitPrice:=aOUnitPrice{aRayLines{$i}}
				Else 
					aOUnitPrice{aRayLines{$i}}:=1
					pUnitPrice:=1
				End if 
			End if 
			aOExtPrice{aRayLines{$i}}:=pExtPrice
			aODscntUP{aRayLines{$i}}:=Round:C94(aOExtPrice{aRayLines{$i}}/aOQtyOrder{aRayLines{$i}}; <>tcDecimalUP+3)
			aODiscnt{aRayLines{$i}}:=(aOUnitPrice{aRayLines{$i}}-aODscntUP{aRayLines{$i}})/aOUnitPrice{aRayLines{$i}}*100
			aOExtPrice{aRayLines{$i}}:=Round:C94(aODscntUP{aRayLines{$i}}*aOQtyOrder{aRayLines{$i}}; <>tcDecimalTt)
			OrdLnExtend(aRayLines{$i})
		End if 
	End for 
	pPricePt:="*"
	vLineMod:=True:C214
End if 