// zzzqqq PopUpWildCard(->[Invoice:26]typeSale:49; -><>aTypeSale; ->[PopUp:23])
If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
	DscntSetPrice([Invoice:26]typeSale:49; <>ptInvoiceDateFld->)
Else 
	DscntSpecialClr([Invoice:26]typeSale:49)
End if 
// jAlertMessage (9207)
vMod:=False:C215
Copy_NewEntry(->[Customer:2]; ->[Invoice:26]typeSale:49; ->[Customer:2]typeSale:18)
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; Self:C308)
pPricePt:=[Invoice:26]typeSale:49
If (Not:C34([Invoice:26]jrnlComplete:48))
	CONFIRM:C162("Update selected lines TypeSale and Item Pricing")
	If (OK=1)
		If ([Invoice:26]timesPrinted:51#0)
			CONFIRM:C162("Account for existing printed copies of this transaction.")
			If (OK=1)
				InvoiceLineResetPrice
			End if 
		Else 
			InvoiceLineResetPrice
		End if 
	End if 
End if 