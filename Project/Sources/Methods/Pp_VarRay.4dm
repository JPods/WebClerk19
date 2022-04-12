//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-04-02T00:00:00, 15:20:44
// ----------------------------------------------------
// Method: Pp_VarRay
// Description
// Modified: 04/02/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


$element:=aPLineAction

C_BOOLEAN:C305($1)
If ($1=True:C214)
	If (aPLineAction{aPLineAction}#-3)
		aPLineAction{aPLineAction}:=-3000
	End if 
	
	
	
	// aPItemNum{$element}:=pPartNum
	aPAltItem{$element}:=pAltItem
	aPDescpt{$element}:=pDescript
	aPQtyOrder{$element}:=pQtyOrd
	aPLeadTime{$element}:=vi2
	aPUnitWt{$element}:=pUtWt
	aPExtWt{$element}:=pFrght
	aPLocation{$element}:=pLocation
	aPUnitPrice{$element}:=pUnitPrice
	aPDiscnt{$element}:=pDiscnt
	aPExtPrice{$element}:=pExtPrice
	aPSaleTax{$element}:=pSalesTax
	aPUnitMeas{$element}:=pUnitMeas
	aPTaxable{$element}:=ptaxID
	aPUnitCost{$element}:=pUnitCost
	aPExtCost{$element}:=pExtCost
	aPSalesRate{$element}:=pCommSPC
	aPRepRate{$element}:=pCommRPC
	aPSaleComm{$element}:=pCommSales
	aPRepComm{$element}:=pCommRep
	aPProdBy{$element}:=pProdBy
	aPLnComment{$element}:=pComment
	aPProfile1{$element}:=pProfile1
	aPProfile2{$element}:=pProfile2
	aPProfile3{$element}:=pProfile3
	aPDateExp{$element}:=vDate1
	aPSeq{$element}:=pSeq
	aPTaxCost{$element}:=pTaxCost
	aPPrintThis{$element}:=pPrintThis
	apLocationBin{$element}:=pLocationBin
	
	
	
Else 
	
	pPartNum:=aPItemNum{$element}
	pAltItem:=aPAltItem{$element}
	pDescript:=aPDescpt{$element}
	pQtyOrd:=aPQtyOrder{$element}
	vi2:=aPLeadTime{$element}
	pUtWt:=aPUnitWt{$element}
	pFrght:=aPExtWt{$element}
	pLocation:=aPLocation{$element}
	pUnitPrice:=aPUnitPrice{$element}
	pDiscnt:=aPDiscnt{$element}
	pExtPrice:=aPExtPrice{$element}
	pSalesTax:=aPSaleTax{$element}
	pUnitMeas:=aPUnitMeas{$element}
	ptaxID:=aPTaxable{$element}
	pUnitCost:=aPUnitCost{$element}
	pExtCost:=aPExtCost{$element}
	pCommSPC:=aPSalesRate{$element}
	pCommRPC:=aPRepRate{$element}
	pCommSales:=aPSaleComm{$element}
	pCommRep:=aPRepComm{$element}
	pProdBy:=aPProdBy{$element}
	pComment:=aPLnComment{$element}
	pProfile1:=aPProfile1{$element}
	pProfile2:=aPProfile2{$element}
	pProfile3:=aPProfile3{$element}
	vDate1:=aPDateExp{$element}
	pSeq:=aPSeq{$element}
	pTaxCost:=aPTaxCost{$element}
	pPrintThis:=aPPrintThis{$element}
	pLocationBin:=apLocationBin{$element}
	
End if 