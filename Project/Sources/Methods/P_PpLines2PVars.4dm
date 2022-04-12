//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/10/06, 17:55:30
// ----------------------------------------------------
// Method: P_PpLines2PVars
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $w)
If (Count parameters:C259#1)
	P_ClearVars
	pvItemNum:="No Line Parameter"
	pvDescription:="No Line Parameter"
Else 
	$w:=$1
	If (($w>0) & ($w<=Size of array:C274(aPItemNum)))
		//    $doSkip:=Num(Not(($1="Skip")&(aPUse{$w}="")))//set = to zero
		$doBlanks:=Num:C11(aPItemNum{$w}#"Comment")  //|($doSkip=0))
		//
		$qtyFormat:="###,###,###,##0.###,###,###"
		pvSeq:=String:C10($w)  //    p_Seq:=String($w+1)
		pvItemNum:=aPItemNum{$w}  //*$doSkip    
		pvAltItem:=aPAltItem{$w}
		pvDescription:=aPDescpt{$w}  //*$doSkip
		pvQtyOrd:=String:C10(aPQtyOrder{$w}; $qtyFormat)*$doBlanks
		pvTaxable:=Num:C11(aPSaleTax{$w}#0)*"X"*$doBlanks
		pvTax:=String:C10(aPSaleTax{$w}; <>tcFormatUP)*$doBlanks
		pvPricePt:=aPPricePt{$w}
		pvBasePrice:=String:C10(aPUnitPrice{$w}; <>tcFormatUP)*$doBlanks
		pvUnitPrice:=String:C10(DiscountApply(aPUnitPrice{$w}; aPDiscnt{$w}; <>tcDecimalUP); <>tcFormatUP)*$doBlanks
		pvDiscount:=String:C10(aPDiscnt{$w}; "##0.0")*$doBlanks
		pvExtPrice:=String:C10(aPExtPrice{$w}; <>tcFormatTt)*$doBlanks
		pvUnitCost:=String:C10(aPUnitCost{$w}; <>tcFormatUC)*$doBlanks
		pvExtCost:=String:C10(aPExtCost{$w}; <>tcFormatTt)*$doBlanks
		pvUnitMeas:=aPUnitMeas{$w}
		pvLocation:=String:C10(aPLocation{$w})*$doBlanks
		pvUse:=aPUse{$w}
		pvUnitWt:=String:C10(aPUnitWt{$w}; <>tcFormatTt)*$doBlanks
		pvExtWt:=String:C10(aPExtWt{$w}; <>tcFormatTt)*$doBlanks
		pvLeadTime:=String:C10(aPLeadTime{$w})*$doBlanks
		pvSerial:="Sr#Item"*Num:C11(aPSerial{$w}#<>ciSRNotSerialized)*$doBlanks
		pvCommRep:=String:C10(aPRepComm{$w}; <>tcFormatTt)*$doBlanks
		pvCommSales:=String:C10(aPSaleComm{$w}; <>tcFormatTt)*$doBlanks
		pvRateRep:=String:C10(Abs:C99(aPRepRate{$w}); "##0.0")*$doBlanks
		pvRateSales:=String:C10(Abs:C99(aPSalesRate{$w}); "##0.0")*$doBlanks
		Case of 
			: ((aPRepComm{$w}=0) & (aPSaleComm{$w}=0))
				pvRateCommt:=""
			: ((aPRepRate{$w}<0) | (aPSalesRate{$w}<0))
				pvRateCommt:="Unit Rate"*$doBlanks
			Else 
				pvRateCommt:="% Rate"*$doBlanks
		End case 
		pvLnProfile1:=aPProfile1{$w}*$doBlanks
		pvLnProfile2:=aPProfile2{$w}*$doBlanks
		pvLnProfile3:=aPProfile3{$w}*$doBlanks
		pvLnComment:=aPLnComment{$w}*$doBlanks
		pvNameID:=aPProdBy{$w}*$doBlanks
		If (([Proposal:42]currency:55#"") & ([Proposal:42]currency:55#<>tcMONEYCHAR))
			fExUnPrice:=String:C10(Round:C94(Round:C94(DiscountApply(aPUnitPrice{$w}; aPDiscnt{$w}; viExConPrec)*[Proposal:42]exchangeRate:54; viExConPrec); viExDisPrec); <>tcFormatUP)*$doBlanks
			fExUnExPrice:=String:C10(Round:C94(Round:C94(Num:C11(fExUnPrice)*aPQtyOrder{$w}; viExDisPrec); viExDisPrec); <>tcFormatTt)*$doBlanks
			//<>exUnCost:=String(aPUnitCost{$w}*[Proposal]ExchangeRate
			//;<>tcFormatUC)*$doBlanks
			//<>exUnExCost:=String(Round(Num(<>exUnCost)*aPQtyOrder{$w}
			//;viExDisPrec);<>tcFormatTt)*$doBlanks
		Else 
			fExUnPrice:=pvUnitPrice
			fExUnExPrice:=pvExtPrice
		End if 
	End if 
End if 