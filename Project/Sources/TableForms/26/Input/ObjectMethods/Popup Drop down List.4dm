If (Self:C308->>1)
	pPricePt:=Self:C308->{Self:C308->}
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
End if 
