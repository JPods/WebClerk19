//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/24/20, 12:06:36
// ----------------------------------------------------
// Method: Exch_Ord
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(strCurrency)  // ### bj ### 20200524_1203  SimplfyQQQ
C_LONGINT:C283($kntLn; $incLn; $curLine; $fiaLnNum; vlDoFrght)
If (([Order:3]exchangeRate:68#0) & ([Order:3]exchangeRate:68#1))
	$kntLn:=Size of array:C274(aOUnitCost)
	If ([Order:3]currency:69#strCurrency)  //Convert to foriegn currency  $1=strCurrency
		Exch_InitRays($kntLn)
		strCurrency:=[Order:3]currency:69
		For ($incLn; 1; $kntLn)
			aExUnitCost{$incLn}:=aOUnitCost{$incLn}
			aExUnitPrc{$incLn}:=aoUnitPrice{$incLn}
			aExLnNum{$incLn}:=aoLineNum{$incLn}
			//      
			aOUnitCost{$incLn}:=Round:C94(aOUnitCost{$incLn}*[Order:3]exchangeRate:68; viExDisPrec)
			aoUnitPrice{$incLn}:=Round:C94(aoUnitPrice{$incLn}*[Order:3]exchangeRate:68; viExDisPrec)
			OrdLnExtend($incLn)
		End for 
		//If ([Invoice]shipAuto=False)
		[Order:3]shipFreightCost:38:=Round:C94([Order:3]exchangeRate:68*[Order:3]shipFreightCost:38; viExDisPrec)
		[Order:3]shipMiscCosts:25:=Round:C94([Order:3]exchangeRate:68*[Order:3]shipMiscCosts:25; viExDisPrec)
		//End if 
		[Order:3]shipAdjustments:26:=Round:C94([Order:3]exchangeRate:68*[Order:3]shipAdjustments:26; viExDisPrec)
		OBJECT SET ENTERABLE:C238([Order:3]exchangeRate:68; False:C215)
		If (aoLineAction<=Size of array:C274(aOItemNum))
			Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
		End if 
	Else 
		OBJECT SET ENTERABLE:C238([Order:3]exchangeRate:68; True:C214)
		strCurrency:=<>tcMONEYCHAR
		For ($incLn; 1; $kntLn)  //restore to base currency
			C_LONGINT:C283($curLine)
			$curLine:=aoLineNum{$incLn}
			$fiaLnNum:=Find in array:C230(aExLnNum; $curLine)
			If ($fiaLnNum>0)
				aOUnitCost{$incLn}:=aExUnitCost{$fiaLnNum}
				aoUnitPrice{$incLn}:=aExUnitPrc{$fiaLnNum}
			Else 
				aOUnitCost{$incLn}:=Round:C94(aOUnitCost{$incLn}/[Order:3]exchangeRate:68; viExConPrec)
				aoUnitPrice{$incLn}:=Round:C94(aoUnitPrice{$incLn}/[Order:3]exchangeRate:68; viExConPrec)
			End if 
			OrdLnExtend($incLn)
		End for 
		Exch_InitRays(0)
		//If ([Order]shipAuto=False)
		[Order:3]shipFreightCost:38:=Round:C94([Order:3]shipFreightCost:38/[Order:3]exchangeRate:68; viExConPrec)
		[Order:3]shipMiscCosts:25:=Round:C94([Order:3]shipMiscCosts:25/[Order:3]exchangeRate:68; viExConPrec)
		//End if 
		[Order:3]shipAdjustments:26:=Round:C94([Order:3]shipAdjustments:26/[Order:3]exchangeRate:68; viExConPrec)  //if zero, does not matter
		vlDoFrght:=2
		If (aoLineAction<=Size of array:C274(aOItemNum))
			Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
		End if 
		vMod:=True:C214
	End if 
End if 