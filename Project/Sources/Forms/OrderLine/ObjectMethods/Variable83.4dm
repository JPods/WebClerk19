C_TEXT:C284(strCurrency)
C_LONGINT:C283($incLn; $k)

If (<>aExchID>1)
	Case of 
		: (<>aExchID{<>aExchID}=strCurrency)
		: ((<>tcMONEYCHAR=strCurrency) | (strCurrency=""))
			$k:=Size of array:C274(aOUnitCost)
			KeyModifierCurrent
			If ((OptKey=1) & ($k>0))
				CONFIRM:C162("Convert to "+<>aExchID{<>aExchID})
				If (OK=1)
					$error:=Exch_GetCurr(<>aExchID{<>aExchID})  //sets viExConPrec, viExDisPrec     
					If (($error#0) & (vrExRate#0))
						For ($incLn; 1; $k)
							aOUnitCost{$incLn}:=Round:C94(aOUnitCost{$incLn}/vrExRate; viExConPrec)
							aoUnitPrice{$incLn}:=Round:C94(aoUnitPrice{$incLn}/vrExRate; viExConPrec)
							OrdLnExtend($incLn)
						End for 
						[Order:3]exchangeRate:68:=vrExRate
						[Order:3]currency:69:=<>aExchID{<>aExchID}
						vMod:=calcOrder(True:C214)
					End if 
					strCurrency:=<>tcMONEYCHAR
				End if 
				vLineMod:=True:C214
				<>aExchID:=1
				aoLineAction:=1
			Else 
				Exch_PopRate(1; ->[Order:3]currency:69; Self:C308; ->[Order:3]exchangeRate:68)
				
				Exch_FillRays
				vMod:=calcOrder(True:C214)
			End if 
		Else 
			Exch_FillRays
			vMod:=calcOrder(True:C214)
			Exch_PopRate(1; ->[Order:3]currency:69; Self:C308; ->[Order:3]exchangeRate:68)
			vMod:=True:C214
			Exch_FillRays
			vMod:=calcOrder(True:C214)
	End case 
End if 