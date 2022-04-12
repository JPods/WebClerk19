If (InvcOkToChange)
	// zzzqqq PopUpWildCard(->[Invoice:26]taxJuris:33; -><>aTaxJuris; ->[TaxJurisdiction:14])
	vMod:=True:C214
	
	CONFIRM:C162("Update Tax ID for selected lines")
	If (OK=1)
		If ([Invoice:26]timesPrinted:51#0)
			CONFIRM:C162("Account for existing printed copies of this transaction.")
			If (OK=1)
				InvoiceLinesResetTaxID
				InvoiceLineResetPrice
			End if 
		Else 
			InvoiceLinesResetTaxID
			InvoiceLineResetPrice
		End if 
	End if 
	
	calcInvoice
	vMod:=True:C214
	Copy_NewEntry(->[Customer:2]; ->[Invoice:26]taxJuris:33; ->[Customer:2]taxJuris:65)
End if 
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; Self:C308)