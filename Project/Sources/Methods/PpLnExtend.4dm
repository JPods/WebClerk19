//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $unitPrec; $totalPrec)
Case of 
	: ((<>tcMONEYCHAR#strCurrency) & ([Proposal:42]currency:55#"") & ([Proposal:42]exchangeRate:54#1) & ([Proposal:42]exchangeRate:54#0))
		$thePrec:=viExDisPrec
	: ((<>tcMONEYCHAR=strCurrency) | ([Proposal:42]currency:55="") | ([Proposal:42]exchangeRate:54=1) | ([Proposal:42]exchangeRate:54=0) | (<>tcMONEYCHAR=""))
		$thePrec:=<>tcDecimalTt
	: (<>tcMONEYCHAR#strCurrency)
		$thePrec:=viExDisPrec  //viExConPrec
	Else 
		$thePrec:=<>tcDecimalTt
End case 
//
If ($thePrec><>tcDecimalUP)
	$discntPrc:=DiscountApply(aPUnitPrice{$1}; aPDiscnt{$1}; $thePrec)
Else 
	$discntPrc:=DiscountApply(aPUnitPrice{$1}; aPDiscnt{$1}; <>tcDecimalUP)
End if 
aPDscntUP{$1}:=Round:C94($discntPrc; <>tcDecimalUP+4)
//
If (aPLineAction{$1}=-3)
	PriceBelowMargi(->aPDscntUP{$1}; ->aPUnitCost{$1}; ->aPItemNum{$1})
	aPQtyOpen{$1}:=aPQtyOrder{$1}
	aPQtyOriginal{$1}:=aPQtyOrder{$1}
End if 
//
$unitMeasBy:=1
If (aPUnitMeas{$1}#"")
	If (aPUnitMeas{$1}[[1]]="*")
		//Jan 11, 1997
		C_REAL:C285($unitMeasBy)
		$unitMeasBy:=Item_PricePer(->aPUnitMeas{$1})
	End if 
End if 
//
pUse:=Num:C11(aPUse{$1}#"")
aPExtWt{$1}:=aPQtyOrder{$1}*aPUnitWt{$1}/$unitMeasBy
pExtPrice:=Round:C94(aPQtyOrder{$1}*$discntPrc/$unitMeasBy; $thePrec)
aPExtCost{$1}:=Round:C94(aPQtyOrder{$1}*aPUnitCost{$1}/$unitMeasBy; $thePrec)
//
aPExtPrice{$1}:=pExtPrice
//TRACE
//aPSaleTax{$1}:=Round(Num(aPTaxable{$1}#"NoTax")*aPExtPrice{$1}*sTaxRate;$thePrec)
TaxCalcLine(->[Proposal:42]taxJuris:33; [Proposal:42]taxExemptId:83; aPTaxable{$1}; aPExtPrice{$1}; aPExtCost{$1}; $1; $thePrec; ->aPSaleTax{$1}; ->aPTaxCost{$1})
//
CM_LineCalc(<>tcSaleMar; $1; ->aPExtPrice; ->aPExtCost; ->aPSalesRate; ->aPSaleComm; ->aPQtyOrder)
CM_LineCalc(<>tcSaleMar; $1; ->aPExtPrice; ->aPExtCost; ->aPRepRate; ->aPRepComm; ->aPQtyOrder)
vMod:=True:C214