//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/11/18, 11:29:17
// ----------------------------------------------------
// Method: OR_VarRay
// Description
// 
//
// Parameters
// ----------------------------------------------------

$element:=aoLineAction

C_BOOLEAN:C305($1)
If ($1=True:C214)
	Case of 
		: (aoLineAction{aoLineAction}=-3)  // except if it is a new line
		: (aoLineAction{aoLineAction}>-1)
			aoLineAction{aoLineAction}:=-3000
		: (aoLineAction{aoLineAction}#-3)
			aoLineAction{aoLineAction}:=-3000
			// since adding -2000 to force PK behavior, need to make sure the line is set to recalc
			// Modified by: William James (2014-08-14T00:00:00 Subrecord eliminated)
			
	End case   //
	
	
	// aOItemNum{$element}:=pPartNum
	aOAltItem{$element}:=pAltItem
	aODescpt{$element}:=pDescript
	aOQtyOrder{$element}:=pQtyOrd
	aOQtyShip{$element}:=pQtyShip
	aOQtyBL{$element}:=pQtyBL
	aOUnitWt{$element}:=pUtWt
	aOPricePt{$element}:=pPricePt
	
	aOExtWt{$element}:=pFrght
	aOLocation{$element}:=pLocation
	aOUnitPrice{$element}:=pUnitPrice
	aODiscnt{$element}:=pDiscnt
	aOExtPrice{$element}:=pExtPrice
	aOSaleTax{$element}:=pSalesTax
	aOUnitMeas{$element}:=pUnitMeas
	
	aOTaxable{$element}:=ptaxID
	aOUnitCost{$element}:=pUnitCost
	aOExtCost{$element}:=pExtCost
	aOSalesRate{$element}:=pCommSPC
	aORepRate{$element}:=pCommRPC
	aOSaleComm{$element}:=pCommSales
	aORepComm{$element}:=pCommRep
	
	aOSerialNm{$element}:=pSerialNum
	aODateReq{$element}:=vLnDate1
	aODateShipOn{$element}:=vLnDate2
	aODateShipped{$element}:=vLnDate3
	aOProdBy{$element}:=pProdBy
	aOLnComment{$element}:=pComment
	aOProfile1{$element}:=pProfile1
	aOProfile2{$element}:=pProfile2
	aOProfile3{$element}:=pProfile3
	
	// aOBackLog{aoLineAction}:=Round(aOQtyBL{aoLineAction}*(DiscountApply (aOUnitPrice{aoLineAction};aODiscnt{aoLineAction};<>tcDecimalUP));<>tcDecimalTt)
	
	aOTaxCost{$element}:=pCostTax
	aOPrintThis{$element}:=pPrintThis
	aOLocationBin{$element}:=pLocationBin
	aOShipOrdSt{$element}:=pShipOrdSt
	aOSeq{$element}:=pSeq
	
	OrdLnExtend($element)
	
Else 
	
	
	pPartNum:=aOItemNum{$element}
	pAltItem:=aOAltItem{$element}
	pDescript:=aODescpt{$element}
	pQtyOrd:=aOQtyOrder{$element}
	pQtyShip:=aOQtyShip{$element}
	pQtyBL:=aOQtyBL{$element}
	pUtWt:=aOUnitWt{$element}
	pPricePt:=aOPricePt{$element}
	
	pFrght:=aOExtWt{$element}
	pLocation:=aOLocation{$element}
	pUnitPrice:=aOUnitPrice{$element}
	pDiscnt:=aODiscnt{$element}
	pExtPrice:=aOExtPrice{$element}
	pSalesTax:=aOSaleTax{$element}
	pUnitMeas:=aOUnitMeas{$element}
	
	ptaxID:=aOTaxable{$element}
	pUnitCost:=aOUnitCost{$element}
	pExtCost:=aOExtCost{$element}
	pCommSPC:=aOSalesRate{$element}
	pCommRPC:=aORepRate{$element}
	pCommSales:=aOSaleComm{$element}
	pCommRep:=aORepComm{$element}
	
	pSerialNum:=aOSerialNm{$element}
	vLnDate1:=aODateReq{$element}
	vLnDate2:=aODateShipOn{$element}
	vLnDate3:=aODateShipped{$element}
	pProdBy:=aOProdBy{$element}
	pComment:=aOLnComment{$element}
	pProfile1:=aOProfile1{$element}
	pProfile2:=aOProfile2{$element}
	pProfile3:=aOProfile3{$element}
	
	pCostTax:=aOTaxCost{$element}
	pPrintThis:=aOPrintThis{$element}
	pLocationBin:=aOLocationBin{$element}
	pShipOrdSt:=aOShipOrdSt{$element}
	pSeq:=aOSeq{$element}
	
End if 

