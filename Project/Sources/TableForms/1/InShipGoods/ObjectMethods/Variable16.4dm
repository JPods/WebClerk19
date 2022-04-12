C_LONGINT:C283($i)
TRACE:C157
If (Size of array:C274(aPoLnSelct)>0)
	For ($i; 1; Size of array:C274(aPoLnSelct))
		If (<>vbDoSrlNums)
			If (aPOSerialRc{aPoLnSelct{$i}}#<>ciSRNotSerialized)
				If ((pQtyOrd<-1) | (pQtyOrd>1))
					ALERT:C41("Serial numbered items may only be sold one to a line.")
					pQtyOrd:=0
				End if 
			End if 
		End if 
		aPOQtyOrder{aPoLnSelct{$i}}:=pQtyOrd
		PoLnExtend(aPoLnSelct{$i})
	End for 
	vLineMod:=True:C214
	vMod:=True:C214
End if 