//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/24/20, 12:01:00
// ----------------------------------------------------
// Method: Exch_Po
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(strCurrency)  // ### bj ### 20200524_1203  SimplfyQQQ
C_LONGINT:C283($kntLn; $incLn; $curLine; $fiaLnNum)
If (([PO:39]exchangeRate:45#0) & ([PO:39]exchangeRate:45#1))
	$kntLn:=Size of array:C274(aPOUnitCost)
	If ([PO:39]currency:46#strCurrency)  //Convert to foriegn currency  $2=strCurrency        
		Exch_InitRays($kntLn)
		strCurrency:=[PO:39]currency:46
		For ($incLn; 1; $kntLn)
			aExUnitCost{$incLn}:=aPOUnitCost{$incLn}
			aExLnNum{$incLn}:=aPOLineNum{$incLn}
			aPOUnitCost{$incLn}:=Round:C94(aPOUnitCost{$incLn}*[PO:39]exchangeRate:45; viExDisPrec)
			PoLnExtend($incLn)
		End for 
		//If ([Po]shipAuto=False)//will recalc in base currency      
		//[Po]ShipFreightCost:=Round([Po]ExchangeRate*[Po]ShipFreightCost
		//;$thePrec)
		//[Po]ShipMiscCosts:=Round([Po]ExchangeRate*[Po]ShipMiscCosts
		//;$thePrec)
		//End if 
		//[Po]ShipAdjustments:=Round([Po]ExchangeRate*[Po]ShipAdjustments
		//;viExDisPrec)
		OBJECT SET ENTERABLE:C238([PO:39]exchangeRate:45; False:C215)
	Else 
		OBJECT SET ENTERABLE:C238([PO:39]exchangeRate:45; True:C214)
		strCurrency:=<>tcMONEYCHAR
		For ($incLn; 1; $kntLn)
			$curLine:=aPOLineNum{$incLn}
			$fiaLnNum:=Find in array:C230(aExLnNum; $curLine)
			If ($fiaLnNum>0)
				aPOUnitCost{$incLn}:=aExUnitCost{$fiaLnNum}
			Else 
				aPOUnitCost{$incLn}:=Round:C94(aPOUnitCost{$incLn}/[PO:39]exchangeRate:45; viExConPrec)
			End if 
			PoLnExtend($incLn)
		End for 
		Exch_InitRays(0)
		//If ([Po]shipAuto=False)//will recalc in base currency if
		// shipAuto is true   
		//[Po]ShipFreightCost:=Round([Po]ShipFreightCost/[Po]ExchangeRate
		//;$thePrec)
		//[Po]ShipMiscCosts:=Round([Po]ShipMiscCosts/[Po]ExchangeRate
		//;$thePrec)
		//End if 
		//[Po]ShipAdjustments:=Round([Po]ShipAdjustments/[Po]ExchangeRate
		//;viExDisPrec)//if zero, does not matter
	End if 
	If (aPOLineAction=Size of array:C274(aPoItemNum))
		PoLnFillVar(aPOLineAction)
	End if 
	vMod:=True:C214
	vLineMod:=True:C214
End if 