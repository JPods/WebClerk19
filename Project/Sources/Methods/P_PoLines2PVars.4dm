//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/06, 11:18:29
// ----------------------------------------------------
// Method: PVars_PoLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

// MustFixQQQZZZ: Bill James (2022-01-27T06:00:00Z)
//  Likely Problem in SuperReport
C_LONGINT:C283(curLines)
C_LONGINT:C283($doBlanks)
//each time through this loop will print a lineIf ((Records in selection([PO])>0)&([UserReport]NumLines#0))
// arrays loaded in the P_PoHeadVars
C_LONGINT:C283($1; $w)
If (Count parameters:C259#1)
	P_ClearVars
	pvItemNum:="No Line Parameter"
	pvDescription:="No Line Parameter"
Else 
	$w:=$1
	If (($w<1) | ($w>Size of array:C274(aPoItemNum)))
		P_ClearVars
		pvItemNum:="No Line Parameter"
		pvDescription:="No Line Parameter"
	Else 
		$doBlanks:=Num:C11(aPoItemNum{$w}#"Comment")
		//
		$qtyFormat:="###,###,###,##0.###,###,###"
		pvSeq:=String:C10($w)  //    p_Seq:=String($w+1)
		pvItemNum:=aPoItemNum{$w}
		pvAltItem:=aPOVndrAlph{$w}
		pvUse:=aPOLnCmplt{$w}*$doBlanks
		pvDescription:=aPoDescpt{$w}
		pvQtyOrd:=String:C10(aPoQtyOrder{$w}; $qtyFormat)*$doBlanks
		pvQtyShip:=String:C10(aPOQtyRcvd{$w}; $qtyFormat)*$doBlanks
		pvQtyBL:=String:C10(aPOQtyBL{$w}; $qtyFormat)*$doBlanks
		pvTaxable:=""  //(aPOTaxable{$w}#0)*""*$doBlanks
		pvTax:=String:C10(aPOVATax{$w}; <>tcFormatUC)*$doBlanks
		pvDiscount:=String:C10(aPoDiscnt{$w}; "##0.0")*$doBlanks
		pvAmountBL:=String:C10(aPOBackLog{$w}; <>tcFormatTt)*$doBlanks
		pvBaseCost:=String:C10(aPoUnitCost{$w}; <>tcFormatUC)*$doBlanks
		pvUnitCost:=String:C10(DiscountApply(aPoUnitCost{$w}; aPoDiscnt{$w}; <>tcDecimalUC); <>tcFormatUC)*$doBlanks
		pvExtCost:=String:C10(aPoExtCost{$w}; <>tcFormatTt)*$doBlanks
		pvUnitMeas:=aPOUnitMeas{$w}*$doBlanks
		//p_UnitWt:=""//String(aPoUnitWt{$w};<>tcFormatTt)*$doBlanks
		//p_ExtWt:=""//String(aPoExtWt{$w};<>tcFormatTt)*$doBlanks
		//p_LeadTime:=""
		//p_Location:=""
		//p_dateProm:=String([OrderLine]DatePromised;1)*$doBlanks
		pvDateReq:=String:C10(aPODateExp{$w}; 1)*$doBlanks
		pvDateShip:=String:C10(aPODateRcvd{$w})*$doBlanks
		
		pvSerial:=(aPOSerialNm{$w})*$doBlanks
		pvReference:=String:C10(aPOOrdRef{$w}; "0000-0000")*$doBlanks
		pvLnComment:=aPoLComment{$w}*$doBlanks
		//  p_NameID:={$w}*$doBlanks
		If (([PO:39]currency:46#"") & ([PO:39]currency:46#<>tcMONEYCHAR))
			C_REAL:C285($UnitCost)
			$UnitCost:=DiscountApply(aPoUnitCost{$w}; aPoDiscnt{$w}; viExConPrec)
			fExUnCost:=String:C10(Round:C94(Round:C94($UnitCost*[PO:39]exchangeRate:45; viExConPrec); viExDisPrec); <>tcFormatUC)*$doBlanks
			fExUnExCost:=String:C10(Round:C94(Num:C11(fExUnPrice)*aPoQtyOrder{$w}; viExDisPrec); <>tcFormatTt)*$doBlanks
		Else 
			fExUnCost:=pvUnitCost
			fExUnExCost:=pvExtCost
		End if 
	End if 
End if 
