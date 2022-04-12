If (Self:C308->>1)
	CONFIRM:C162("Update selected lines TypeSale and Item Pricing")
	If (OK=1)
		pPricePt:=Self:C308->{Self:C308->}
		ProposalLinesResetPrice
	End if 
End if 
