//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/24/20, 12:06:03
// ----------------------------------------------------
// Method: Exch_Inv
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(strCurrency)  // ### bj ### 20200524_1203  SimplfyQQQ
C_LONGINT:C283(viExDisPrec; viExConPrec)
If (([Invoice:26]exchangeRate:61#0) & ([Invoice:26]exchangeRate:61#1))
	//one time changes should be done here
	C_LONGINT:C283($kntLn; $incLn; $curLine; $fiaLnNum)
	$kntLn:=Size of array:C274(aiUnitCost)
	If ([Invoice:26]currency:62#strCurrency)  //Convert to foriegn currency  $2=strCurrency
		Exch_InitRays($kntLn)
		strCurrency:=[Invoice:26]currency:62
		For ($incLn; 1; $kntLn)
			aExUnitCost{$incLn}:=aiUnitCost{$incLn}
			aExUnitPrc{$incLn}:=aiUnitPrice{$incLn}
			aExLnNum{$incLn}:=aiLineNum{$incLn}
			aiUnitCost{$incLn}:=Round:C94(aiUnitCost{$incLn}*[Invoice:26]exchangeRate:61; viExDisPrec)
			aiUnitPrice{$incLn}:=Round:C94(aiUnitPrice{$incLn}*[Invoice:26]exchangeRate:61; viExDisPrec)
			IvcLnExtend($incLn)
		End for 
		//[Invoice]BalanceDue:=Round([Invoice]BalanceDue*[Invoice]ExchangeRate
		//;viExDisPrec)
		//calculate in std procedure
		//one time changes should be done here
		//If ([Invoice]shipAuto=False)//will recalc in base currency   
		//TRACE
		[Invoice:26]shipFreightCost:15:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]shipFreightCost:15; viExDisPrec)
		[Invoice:26]shipMiscCosts:16:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]shipMiscCosts:16; viExDisPrec)
		//End if 
		[Invoice:26]shipAdjustments:17:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]shipAdjustments:17; viExDisPrec)
		[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45*[Invoice:26]exchangeRate:61; viExDisPrec)
		[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46*[Invoice:26]exchangeRate:61; viExDisPrec+4)  //prevent rounding error
		OBJECT SET ENTERABLE:C238([Invoice:26]exchangeRate:61; False:C215)
	Else 
		OBJECT SET ENTERABLE:C238([Invoice:26]exchangeRate:61; True:C214)
		strCurrency:=<>tcMONEYCHAR
		For ($incLn; 1; $kntLn)
			$curLine:=aiLineNum{$incLn}
			$fiaLnNum:=Find in array:C230(aExLnNum; $curLine)
			If ($fiaLnNum>0)
				aiUnitCost{$incLn}:=aExUnitCost{$fiaLnNum}
				aiUnitPrice{$incLn}:=aExUnitPrc{$fiaLnNum}
			Else 
				aiUnitCost{$incLn}:=Round:C94(aiUnitCost{$incLn}/[Invoice:26]exchangeRate:61; viExConPrec)
				aiUnitPrice{$incLn}:=Round:C94(aiUnitPrice{$incLn}/[Invoice:26]exchangeRate:61; viExConPrec)
			End if 
			IvcLnExtend($incLn)
		End for 
		Exch_InitRays(0)
		//If ([Invoice]shipAuto=False)//will recalc in base currency if shipAuto i
		[Invoice:26]shipFreightCost:15:=Round:C94([Invoice:26]shipFreightCost:15/[Invoice:26]exchangeRate:61; viExConPrec)
		[Invoice:26]shipMiscCosts:16:=Round:C94([Invoice:26]shipMiscCosts:16/[Invoice:26]exchangeRate:61; viExConPrec)
		// End if 
		[Invoice:26]shipAdjustments:17:=Round:C94([Invoice:26]shipAdjustments:17/[Invoice:26]exchangeRate:61; viExConPrec)
		//if zero, does not matter
		[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45/[Invoice:26]exchangeRate:61; viExConPrec)
		[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46/[Invoice:26]exchangeRate:61; viExDisPrec+4)  //prevent rounding error
	End if 
	vMod:=True:C214
	If (aiLineAction=Size of array:C274(aiItemNum))
		//   IvcLnFillVar(aiLineAction)
	End if 
	//calcInvoice (vMod)
End if 