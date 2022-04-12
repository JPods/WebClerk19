C_TEXT:C284(strCurrency)
C_LONGINT:C283($incLn; $k)
TRACE:C157
If (<>aExchID>1)
	Case of 
		: (<>aExchID{<>aExchID}=strCurrency)
		: ((<>tcMONEYCHAR=strCurrency) | (strCurrency=""))
			$k:=Size of array:C274(aPUnitCost)
			KeyModifierCurrent
			If ((OptKey=1) & ($k>0))
				CONFIRM:C162("Convert to "+<>aExchID{<>aExchID})
				If (OK=1)
					$error:=Exch_GetCurr(<>aExchID{<>aExchID})  //sets viExConPrec, viExDisPrec     
					If (($error#0) & (vrExRate#0))
						For ($incLn; 1; $k)
							aPUnitCost{$incLn}:=Round:C94(aPUnitCost{$incLn}/vrExRate; viExConPrec)
							aPUnitPrice{$incLn}:=Round:C94(aPUnitPrice{$incLn}/vrExRate; viExConPrec)
							PpLnExtend($incLn)
						End for 
						[Proposal:42]exchangeRate:54:=vrExRate
						[Proposal:42]currency:55:=<>aExchID{<>aExchID}
						vMod:=calcProposal(True:C214)
					End if 
					strCurrency:=<>tcMONEYCHAR
				End if 
				vLineMod:=True:C214
				<>aExchID:=1
				aPpLineRec:=1
			Else 
				Exch_PopRate(1; ->[Proposal:42]currency:55; Self:C308; ->[Proposal:42]exchangeRate:54)  //<>aExchID
				Exch_FillRays
				vMod:=calcProposal(True:C214)
			End if 
		Else 
			Exch_FillRays
			vMod:=calcProposal(True:C214)
			Exch_PopRate(1; ->[Proposal:42]currency:55; Self:C308; ->[Proposal:42]exchangeRate:54)  //<>aExchID
			Exch_FillRays
			vMod:=calcProposal(True:C214)
	End case 
End if 