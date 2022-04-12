If ((<>vbDoSrlNums) & (pSerialized#<>ciSRNotSerialized))
	ALERT:C41("Serial numbered changes only in main screen.")
	pQtyOrd:=aPOQtyOrder{aPOLineAction}
	pQtyShip:=aPOQtyRcvd{aPOLineAction}
	pQtyBL:=aPOQtyBL{aPOLineAction}
Else 
	pQtyOrd:=pQtyShip+pQtyBL
End if 
doSearch:=1