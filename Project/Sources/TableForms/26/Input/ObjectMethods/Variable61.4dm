entryEntity.taxJuris:=DE_PopUpArray(Self:C308)
If ([Invoice:26]jrnlComplete:48)
	[Invoice:26]taxJuris:33:=Old:C35([Invoice:26]taxJuris:33)
	BEEP:C151
	BEEP:C151
Else 
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
	vMod:=True:C214
	calcInvoice
	vMod:=True:C214
	Copy_NewEntry(->[Customer:2]; ->[Invoice:26]taxJuris:33; ->[Customer:2]taxJuris:65)
End if 
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]taxJuris:33)