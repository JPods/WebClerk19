C_TEXT:C284(strCurrency)
C_LONGINT:C283($incLn; $k)
TRACE:C157
If (<>aExchID>1)
	Case of 
		: (<>aExchID{<>aExchID}=strCurrency)
		: ((<>tcMONEYCHAR=strCurrency) | (strCurrency=""))
			$k:=Size of array:C274(aPoUnitCost)
			KeyModifierCurrent
			If ((OptKey=1) & ($k>0))
				CONFIRM:C162("Convert to "+<>aExchID{<>aExchID})
				If (OK=1)
					$error:=Exch_GetCurr(<>aExchID{<>aExchID})  //sets viExConPrec, viExDisPrec     
					If (($error#0) & (vrExRate#0))
						For ($incLn; 1; $k)
							aPoUnitCost{$incLn}:=Round:C94(aPoUnitCost{$incLn}/vrExRate; viExConPrec)
							PoLnExtend($incLn)
						End for 
						[PO:39]exchangeRate:45:=vrExRate
						[PO:39]currency:46:=<>aExchID{<>aExchID}
						vMod:=calcPO(True:C214)
					End if 
					strCurrency:=<>tcMONEYCHAR
				End if 
				vLineMod:=True:C214
				<>aExchID:=1
				aPOLineAction:=1
			Else 
				Exch_PopRate(1; ->[PO:39]currency:46; Self:C308; ->[PO:39]exchangeRate:45)
				Exch_FillRays
				vMod:=calcPO(True:C214)
			End if 
		Else 
			Exch_FillRays
			vMod:=calcPO(True:C214)
			Exch_PopRate(1; ->[PO:39]currency:46; Self:C308; ->[PO:39]exchangeRate:45)
			Exch_FillRays
			vMod:=calcPO(True:C214)
	End case 
End if 