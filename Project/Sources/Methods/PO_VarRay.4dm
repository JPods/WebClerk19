//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($1)
C_LONGINT:C283(pRefNum)
C_REAL:C285(pExtWt; pUnWt)
C_LONGINT:C283($element)

$element:=aPOLineAction

If ($1=True:C214)
	// variable to array
	
	//don't do this,   //must keep the record number for inventory
	//If (aPOLineAction{aPOLineAction}>-1)   
	//aPOLineAction{aPOLineAction}:=-3000
	//End if    
	
	
	// aPoItemNum{$element}:=pPartNum
	aPOQtyOrder{$element}:=pQtyOrd
	aPOQtyRcvd{$element}:=pQtyShip
	aPOQtyBL{$element}:=pQtyBL
	aPODescpt{$element}:=pDescript
	aPOUnitCost{$element}:=pUnitPrice
	aPODiscnt{$element}:=pDiscnt
	aPOExtCost{$element}:=pExtPrice
	aPOUnitMeas{$element}:=pUnitMeas
	aPOSerialRc{$element}:=pSerialized
	aPOSerialNm{$element}:=pSerialNum
	aPOVndrAlph{$element}:=pVendItem
	aPODateExp{$element}:=vDate1
	aPODateRcvd{$element}:=vDate2
	aPOOrdRef{$element}:=pRefNum
	aPoLComment{$element}:=pComment
	aPoNPCosts{$element}:=pNonPCost
	aPoDuties{$element}:=pSalesTax
	aPoUnitWt{$element}:=pUnWt
	aPoExtWt{$element}:=pExtWt
	aPOVATax{$element}:=pVaTax
	
	
	
	
	// aPOBackLog{aPOLineAction}:=Round(aPOQtyBL{aPOLineAction}*DiscountApply (aPOUnitCost{aPOLineAction};aPODiscnt{aPOLineAction};<>tcDecimalUC);<>tcDecimalUC)
	//  
	If (Size of array:C274(aExLnNum)>0)
		Exch_dPriceCost(->[PO:39]exchangeRate:45; ->aPoLineNum{aPOLineAction})
		C_LONGINT:C283($fiaLine)
		$fiaLine:=Find in array:C230(aExLnNum; aPoLineNum{aPOLineAction})
		If ($fiaLine>0)
			aExUnitCost{$fiaLine}:=aExUnitPrc{$fiaLine}
		End if 
	End if 
Else 
	// array to variable
	
	pPartNum:=aPoItemNum{$element}
	pQtyOrd:=aPOQtyOrder{$element}
	pQtyShip:=aPOQtyRcvd{$element}
	pQtyBL:=aPOQtyBL{$element}
	pDescript:=aPODescpt{$element}
	pUnitPrice:=aPOUnitCost{$element}
	pDiscnt:=aPODiscnt{$element}
	pExtPrice:=aPOExtCost{$element}
	pUnitMeas:=aPOUnitMeas{$element}
	pSerialized:=aPOSerialRc{$element}
	pSerialNum:=aPOSerialNm{$element}
	pVendItem:=aPOVndrAlph{$element}
	vDate1:=aPODateExp{$element}
	vDate2:=aPODateRcvd{$element}
	pRefNum:=aPOOrdRef{$element}
	pComment:=aPoLComment{$element}
	pNonPCost:=aPoNPCosts{$element}
	pSalesTax:=aPoDuties{$element}
	pUnWt:=aPoUnitWt{$element}
	pExtWt:=aPoExtWt{$element}
	pVaTax:=aPOVATax{$element}
	
End if 