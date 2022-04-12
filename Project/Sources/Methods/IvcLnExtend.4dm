//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $unitPrec; $totalPrec; $thePrec)
If ($1>0)
	Case of 
		: ((<>tcMONEYCHAR#strCurrency) & ([Invoice:26]currency:62#"") & ([Invoice:26]exchangeRate:61#1) & ([Invoice:26]exchangeRate:61#0))
			$thePrec:=viExDisPrec
		: ((<>tcMONEYCHAR=strCurrency) | ([Invoice:26]currency:62="") | ([Invoice:26]exchangeRate:61=1) | ([Invoice:26]exchangeRate:61=0) | (<>tcMONEYCHAR=""))
			$thePrec:=<>tcDecimalTt
		: (<>tcMONEYCHAR#strCurrency)
			$thePrec:=viExDisPrec  //viExConPrec
		Else 
			$thePrec:=<>tcDecimalTt
	End case 
	C_REAL:C285($discntPrc)
	//If (aiLineAction{$1}=-3)  // aiLineAction is used to set flag relative to recalculating
	
	C_BOOLEAN:C305($existingOrderLine)
	$existingOrderLine:=(aiLnOrdUnique{$1}>0)
	aiQtyBL{$1}:=aiQtyRemain{$1}-aiQtyShip{$1}
	//End if 
	
	// Modified by: William James (2014-01-20T00:00:00)
	// Notes that the line might have changed and needs to be saved
	
	If (aiLineAction{$1}>-1)
		aiLineAction{$1}:=-3000
	End if 
	pQtyBL:=aiQtyBL{$1}
	
	If ($thePrec><>tcDecimalUP)
		$discntPrc:=DiscountApply(aiUnitPrice{$1}; aiDiscnt{$1}; $thePrec)
	Else 
		$discntPrc:=DiscountApply(aiUnitPrice{$1}; aiDiscnt{$1}; <>tcDecimalUP)
	End if 
	
	aiUnitPriceDiscounted{$1}:=Round:C94($discntPrc; <>tcDecimalUP+4)
	If (aiLineAction{$1}=-3)
		PriceBelowMargi(->aiUnitPriceDiscounted{$1}; ->aiUnitCost{$1}; ->aiItemNum{$1})
	End if 
	//  
	$unitMeasBy:=1
	C_TEXT:C284($unitMeasureValue)
	If (Length:C16(aiUnitMeas{$1})>0)
		$unitMeasureValue:=aiUnitMeas{$1}[[1]]
		If ($unitMeasureValue="*")
			//Jan 11, 1997
			C_REAL:C285($unitMeasBy)
			$unitMeasBy:=Item_PricePer(->aiUnitMeas{$1})
		End if 
	End if 
	//
	aiExtWt{$1}:=aiUnitWt{$1}*aiQtyShip{$1}/$unitMeasBy
	pExtPrice:=Round:C94(aiQtyShip{$1}/$unitMeasBy*$discntPrc; $thePrec)
	aiExtCost{$1}:=Round:C94((aiQtyShip{$1}*aiUnitCost{$1}/$unitMeasBy); $thePrec)  // ### jwm ### 20170801_1515 should this be <>tcDecimalUC
	//
	aiExtPrice{$1}:=pExtPrice
	//aiSaleTax{$1}:=Round(Num(aiTaxable{$1}#"NoTax")*aiExtPrice{$1}*sTaxRate;$thePrec)
	TaxCalcLine(->[Invoice:26]taxJuris:33; [Invoice:26]taxExemptId:91; aiTaxable{$1}; aiExtPrice{$1}; aiExtCost{$1}; $1; $thePrec; ->aiSaleTax{$1}; ->aiTaxCost{$1})
	
	CM_LineCalc(<>tcSaleMar; $1; ->aiExtPrice; ->aiExtCost; ->aiSalesRate; ->aiSaleComm; ->aiQtyShip)
	CM_LineCalc(<>tcSaleMar; $1; ->aiExtPrice; ->aiExtCost; ->aiRepRate; ->aiRepComm; ->aiQtyShip)
	vMod:=True:C214
End if 