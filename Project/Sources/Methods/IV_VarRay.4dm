//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/11/18, 15:14:17
// ----------------------------------------------------
// Method: IV_VarRay
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1)
C_LONGINT:C283($element)

$element:=aiLineAction

If ($1=True:C214)
	// Variable to array
	If (aiLineAction{aiLineAction}>-1)
		aiLineAction{aiLineAction}:=-3000
	End if 
	
	// aiItemNum{$element}:=pPartNum
	aiAltItem{$element}:=pAltItem
	aiDescpt{$element}:=pDescript
	aiQtyRemain{$element}:=pQtyOrd
	aiQtyShip{$element}:=pQtyShip
	aiQtyBL{$element}:=pQtyBL
	aiUnitWt{$element}:=pUtWt
	
	aiExtWt{$element}:=pFrght
	aiUnitMeas{$element}:=pUnitMeas
	aiLocation{$element}:=pLocation
	aiUnitPrice{$element}:=pUnitPrice
	aiDiscnt{$element}:=pDiscnt
	aiExtPrice{$element}:=pExtPrice
	aiSaleTax{$element}:=pSalesTax
	
	aiTaxable{$element}:=ptaxID
	aiUnitCost{$element}:=pUnitCost
	aiExtCost{$element}:=pExtCost
	aiSalesRate{$element}:=pCommSPC
	aiRepRate{$element}:=pCommRPC
	aiSaleComm{$element}:=pCommSales
	
	aiRepComm{$element}:=pCommRep
	aiSerialNm{$element}:=pSerialNum
	aiProdBy{$element}:=pProdBy
	aiLnComment{$element}:=pComment
	aiShipOrdSt{$element}:=pShipOrdSt
	aiProfile1{$element}:=pProfile1
	aiProfile2{$element}:=pProfile2
	aiProfile3{$element}:=pProfile3
	
	aiTaxCost{$element}:=pCostTax
	aiPrintThis{$element}:=pPrintThis
	aiLocationBin{$element}:=pLocationBin
	aiSeq{$element}:=pSeq
	
	
Else 
	//  array to varible
	
	pPartNum:=aiItemNum{$element}
	pAltItem:=aiAltItem{$element}
	pDescript:=aiDescpt{$element}
	pQtyOrd:=aiQtyRemain{$element}
	pQtyShip:=aiQtyShip{$element}
	pQtyBL:=aiQtyBL{$element}
	pUtWt:=aiUnitWt{$element}
	
	pFrght:=aiExtWt{$element}
	pUnitMeas:=aiUnitMeas{$element}
	pLocation:=aiLocation{$element}
	pUnitPrice:=aiUnitPrice{$element}
	pDiscnt:=aiDiscnt{$element}
	pExtPrice:=aiExtPrice{$element}
	pSalesTax:=aiSaleTax{$element}
	
	ptaxID:=aiTaxable{$element}
	pUnitCost:=aiUnitCost{$element}
	pExtCost:=aiExtCost{$element}
	pCommSPC:=aiSalesRate{$element}
	pCommRPC:=aiRepRate{$element}
	pCommSales:=aiSaleComm{$element}
	
	pCommRep:=aiRepComm{$element}
	pSerialNum:=aiSerialNm{$element}
	pProdBy:=aiProdBy{$element}
	pComment:=aiLnComment{$element}
	pShipOrdSt:=aiShipOrdSt{$element}
	pProfile1:=aiProfile1{$element}
	pProfile2:=aiProfile2{$element}
	pProfile3:=aiProfile3{$element}
	
	pCostTax:=aiTaxCost{$element}
	pPrintThis:=aiPrintThis{$element}
	pLocationBin:=aiLocationBin{$element}
	pSeq:=aiSeq{$element}
	
	
End if 