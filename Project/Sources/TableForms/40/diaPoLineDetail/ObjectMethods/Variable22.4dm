If ((<>vbDoSrlNums) & (pSerialized#<>ciSRNotSerialized))
	PoLineRecv
	//ALERT("Serial numbered changes only in main screen.")
	//pQtyOrd:=aPOQtyOrder{aPOLineAction}
	//pQtyShip:=aPOQtyRcvd{aPOLineAction}
	//pQtyBL:=aPOQtyBL{aPOLineAction}
Else 
	pQtyBL:=pQtyOrd-pQtyShip
End if 
doSearch:=1