C_LONGINT:C283($incLn; $k)
If (<>aExchID>1)
	Case of 
		: (<>aExchID{<>aExchID}=strCurrency)
		: ((<>tcMONEYCHAR=strCurrency) | (strCurrency=""))
			$k:=Size of array:C274(aiUnitCost)
			KeyModifierCurrent
			If ((OptKey=1) & ($k>0))
				CONFIRM:C162("Convert to "+<>aExchID{<>aExchID})
				If (OK=1)
					$error:=Exch_GetCurr(<>aExchID{<>aExchID})  //sets viExConPrec, viExDisPrec     
					If (($error#0) & (vrExRate#0))
						For ($incLn; 1; $k)
							aiUnitCost{$incLn}:=Round:C94(aiUnitCost{$incLn}/vrExRate; viExConPrec)
							aiUnitPrice{$incLn}:=Round:C94(aiUnitPrice{$incLn}/vrExRate; viExConPrec)
							IvcLnExtend($incLn)
						End for 
						[Invoice:26]exchangeRate:61:=vrExRate
						[Invoice:26]currency:62:=<>aExchID{<>aExchID}
						TRACE:C157
						[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45/vrExRate; viExConPrec)
						[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46/vrExRate; viExConPrec)
						[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]balanceDue:44/vrExRate; viExConPrec)
						
						vMod:=calcInvoice(True:C214)
					End if 
					strCurrency:=<>tcMONEYCHAR
				End if 
				vLineMod:=True:C214
				<>aExchID:=1
				aiLineAction:=1
			Else 
				Exch_PopRate(1; ->[Invoice:26]currency:62; Self:C308; ->[Invoice:26]exchangeRate:61)  //<>aExchID
				Exch_FillRays
				vMod:=calcInvoice(True:C214)
			End if 
		Else 
			Exch_FillRays
			vMod:=calcInvoice(True:C214)
			Exch_PopRate(1; ->[Invoice:26]currency:62; Self:C308; ->[Invoice:26]exchangeRate:61)  //<>aExchID
			Exch_FillRays
			vMod:=calcInvoice(True:C214)
	End case 
End if 