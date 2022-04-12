//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/24/20, 12:00:31
// ----------------------------------------------------
// Method: Exch_Pp
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(strCurrency)  // ### bj ### 20200524_1203  SimplfyQQQ
C_LONGINT:C283($kntLn; $incLn; $curLine; $fiaLnNum)

If (([Proposal:42]exchangeRate:54#0) & ([Proposal:42]exchangeRate:54#1))
	$kntLn:=Size of array:C274(aPUnitCost)
	If ([Proposal:42]currency:55#strCurrency)  //Convert to foriegn currency  strCurrency
		Exch_InitRays($kntLn)
		strCurrency:=[Proposal:42]currency:55
		For ($incLn; 1; $kntLn)
			aExUnitCost{$incLn}:=aPUnitCost{$incLn}
			aExUnitPrc{$incLn}:=aPUnitPrice{$incLn}
			aExLnNum{$incLn}:=aPLineNum{$incLn}
			aPUnitCost{$incLn}:=Round:C94(aPUnitCost{$incLn}*[Proposal:42]exchangeRate:54; viExDisPrec)
			aPUnitPrice{$incLn}:=Round:C94(aPUnitPrice{$incLn}*[Proposal:42]exchangeRate:54; viExDisPrec)
			PpLnExtend($incLn)
		End for 
		If ([Proposal:42]autoFreight:38=False:C215)
			[Proposal:42]shipFreightCost:30:=Round:C94([Proposal:42]exchangeRate:54*[Proposal:42]shipFreightCost:30; viExDisPrec)
			[Proposal:42]shipMiscCosts:29:=Round:C94([Proposal:42]exchangeRate:54*[Proposal:42]shipMiscCosts:29; viExDisPrec)
		End if 
		[Proposal:42]shipAdjustments:28:=Round:C94([Proposal:42]exchangeRate:54*[Proposal:42]shipAdjustments:28; viExDisPrec)
		OBJECT SET ENTERABLE:C238([Proposal:42]exchangeRate:54; False:C215)
	Else 
		OBJECT SET ENTERABLE:C238([Proposal:42]exchangeRate:54; True:C214)
		strCurrency:=<>tcMONEYCHAR
		For ($incLn; 1; $kntLn)
			$curLine:=aPLineNum{$incLn}
			$fiaLnNum:=Find in array:C230(aExLnNum; $curLine)
			If ($fiaLnNum>0)
				aPUnitCost{$incLn}:=aExUnitCost{$fiaLnNum}
				aPUnitPrice{$incLn}:=aExUnitPrc{$fiaLnNum}
			Else 
				aPUnitCost{$incLn}:=Round:C94(aPUnitCost{$incLn}/[Proposal:42]exchangeRate:54; viExConPrec)
				aPUnitPrice{$incLn}:=Round:C94(aPUnitPrice{$incLn}/[Proposal:42]exchangeRate:54; viExConPrec)
			End if 
			PpLnExtend($incLn)
		End for 
		Exch_InitRays(0)
		If ([Proposal:42]autoFreight:38=False:C215)
			[Proposal:42]shipFreightCost:30:=Round:C94([Proposal:42]shipFreightCost:30/[Proposal:42]exchangeRate:54; viExConPrec)
			[Proposal:42]shipMiscCosts:29:=Round:C94([Proposal:42]shipMiscCosts:29/[Proposal:42]exchangeRate:54; viExConPrec)
		End if 
		[Proposal:42]shipAdjustments:28:=Round:C94([Proposal:42]shipAdjustments:28/[Proposal:42]exchangeRate:54; viExConPrec)  //if zero, does not matter 
		If (aPLineAction=Size of array:C274(aPItemNum))
			Ln_FillVar(aPLineAction; ->aPItemNum; ->aPDescpt; Num:C11(aPUse{aPLineAction}=""); aPQtyOrder{aPLineAction}; 0; aPUnitPrice{aPLineAction}; aPDiscnt{aPLineAction}; aPExtPrice{aPLineAction}; aPPricePt{aPLineAction})
		End if 
		vMod:=True:C214
	End if 
End if 