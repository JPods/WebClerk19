//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $unitPrec; $totalPrec; $thePrec)
Case of 
	: ((<>tcMONEYCHAR#strCurrency) & ([PO:39]currency:46#"") & ([PO:39]exchangeRate:45#1) & ([PO:39]exchangeRate:45#0))
		$thePrec:=viExDisPrec
	: ((<>tcMONEYCHAR=strCurrency) | ([PO:39]currency:46="") | ([PO:39]exchangeRate:45=1) | ([PO:39]exchangeRate:45=0) | (<>tcMONEYCHAR=""))
		$thePrec:=<>tcDecimalTt
	: (<>tcMONEYCHAR#strCurrency)
		$thePrec:=viExDisPrec  //viExConPrec
	Else 
		$thePrec:=<>tcDecimalTt
End case 
//don't do this,   //must keep the record number for inventory
//If (aPOLineAction{aPOLineAction}>-1)   
//aPOLineAction{aPOLineAction}:=-3000
//End if 
C_REAL:C285($qtyBLQ)
aPOQtyBL{$1}:=(aPOQtyOrder{$1}-aPOQtyRcvd{$1})*Num:C11(aPOLnCmplt{$1}="")  //$qtyBLQ:=
If ((aPOQtyOrder{$1}#0) & (aPOQtyBL{$1}=0))  //if it is completed by count but not checked
	aPOLnCmplt{$1}:="x"
	pUse:=1
Else 
	pUse:=0
End if 
//
$unitMeasBy:=1
If (aPoUnitMeas{$1}#"")
	If (aPoUnitMeas{$1}[[1]]="*")
		//Jan 11, 1997
		C_REAL:C285($unitMeasBy)
		$unitMeasBy:=Item_PricePer(->aPoUnitMeas{$1})
	End if 
End if 
//
aPoDscntUP{$1}:=Round:C94(DiscountApply(aPOUnitCost{$1}; aPODiscnt{$1}; 15); <>tcDecimalUC+4)
If (aPOLnCmplt{$1}#"")
	aPOExtCost{$1}:=Round:C94(aPOQtyRcvd{$1}*aPoDscntUP{$1}/$unitMeasBy; $thePrec)
Else 
	aPOExtCost{$1}:=Round:C94(aPOQtyOrder{$1}*aPoDscntUP{$1}/$unitMeasBy; $thePrec)
End if 
// [POLine]VATax:=Num([POLine]Taxable)*[POLine]ExtendedPrice*sTaxRate
If (aPOQtyBL{$1}#0)
	aPOBackLog{$1}:=Round:C94(aPOQtyBL{$1}*aPoDscntUP{$1}/$unitMeasBy; $thePrec)
Else 
	aPOBackLog{$1}:=0
End if 
pExtPrice:=aPOExtCost{$1}
vMod:=True:C214