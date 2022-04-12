//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
If ($1>0)
	pPartNum:=aPoItemNum{$1}
	pQtyOrd:=aPOQtyOrder{$1}
	If (bRecByChang=0)
		pQtyShip:=aPOQtyRcvd{$1}
	Else 
		pQtyShip:=aPOQtyNow{$1}
	End if 
	pDescript:=aPODescpt{$1}
	pUnitPrice:=aPOUnitCost{$1}
	pDiscnt:=aPODiscnt{$1}
	pExtPrice:=aPOExtCost{$1}
	pNonPCost:=aPoNPCosts{$1}
	pSalesTax:=aPoDuties{$1}
	// Modified by: Bill James (2017-08-21T00:00:00 - missing specialCharacter to x)
	pUse:=Num:C11(aPOLnCmplt{$1}#"")  // generally x
Else 
	pQtyOrd:=0
	pQtyShip:=0
	pPartNum:=""
	pDescript:=""
	pUnitPrice:=0
	pDiscnt:=0
	pExtPrice:=0
	pUse:=0
	pNonPCost:=0
	pSalesTax:=0
	ARRAY LONGINT:C221(aPoLnSelct; 0)
End if 
C_REAL:C285(pNonPCost)