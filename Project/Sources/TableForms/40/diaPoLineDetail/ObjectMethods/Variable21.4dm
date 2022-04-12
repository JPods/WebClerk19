If ((<>vbDoSrlNums) & (pSerialized#<>ciSRNotSerialized))
	ALERT:C41("Serial numbered changes only in main screen.")
	pQtyOrd:=aPOQtyOrder{aPOLineAction}
	pQtyShip:=aPOQtyRcvd{aPOLineAction}
	pQtyBL:=aPOQtyBL{aPOLineAction}
Else 
	If (<>vbItemBundle)
		pQtyOrd:=Item_BundleCheck(pPartNum; pQtyOrd)
	End if 
	pQtyBL:=pQtyOrd-pQtyShip
End if 
doSearch:=1