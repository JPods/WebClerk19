If (<>vbItemBundle)
	pQtyOrd:=Item_BundleCheck(pPartNum; pQtyOrd)
End if 
If (ptCurTable=(->[Order:3]))
	pQtyBL:=pQtyOrd-pQtyShip
Else   //Invoice
	pQtyShip:=pQtyOrd
End if 
myOK:=1