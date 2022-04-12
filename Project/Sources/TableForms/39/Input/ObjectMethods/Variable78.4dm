//ON ERR CALL("jOECpwSignOff")
error:=0
$k:=Size of array:C274(aRayLines)
If ($k>0)
	For ($i; 1; $k)
		aPOLineAction:=aRayLines{$i}
		PoLineRecv
		If (error#0)
			If (aPOLineAction>0)
				pQtyShip:=aPOQtyRcvd{aPOLineAction}
			Else 
				pQtyShip:=0
			End if 
		Else 
			vLineMod:=True:C214
		End if 
	End for 
End if 
// -- AL_SetSelect(ePoList; aRayLines)
//ON ERR CALL("")