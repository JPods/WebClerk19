TRACE:C157
C_LONGINT:C283(b33; $i; $k)
If (b33=0)  //in packing window
	bRecByChang:=1
	error:=0
	$k:=Size of array:C274(aPoLnSelct)
	For ($i; 1; $k)
		aPOLineAction:=aPoLnSelct{$i}
		PoLineRecv
		If (error#0)
			If (aPOLineAction>0)
				pQtyShip:=aPOQtyRcvd{aPOLineAction}
			Else 
				pQtyShip:=0
			End if 
		Else 
			vLineMod:=True:C214
			vMod:=True:C214
		End if 
	End for 
Else 
	aPoHoldQty{aPOLineAction}:=pQtyShip
End if 