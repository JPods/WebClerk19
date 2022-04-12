entryEntity.typeSale:=DE_PopUpArray(Self:C308)
DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Invoice:26]typeSale:49; [Invoice:26]dateInvoiced:35)
//If ((<>tcbManyType)&([Customer]customerID#""))
//DscntSetPrice (->[Invoice]TypeSale;<>ptInvoiceDateFld)
//Else 
//DscntSpecialClr (->[Invoice]TypeSale)
//End if 
// jAlertMessage (9207)
vMod:=False:C215
Copy_NewEntry(->[Customer:2]; ->[Invoice:26]typeSale:49; ->[Customer:2]typeSale:18)
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]typeSale:49)
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