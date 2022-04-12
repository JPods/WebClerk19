//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-14T00:00:00, 12:02:37
// ----------------------------------------------------
// Method: iLoOrders_ResetPricePoint
// Description
// Modified: 08/14/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (Self:C308->>1)
	pPricePt:=Self:C308->{Self:C308->}
	CONFIRM:C162("Update selected lines TypeSale and Item Pricing")
	If (OK=1)
		If ([Order:3]timesPrinted:39#0)
			CONFIRM:C162("Account for existing printed copies of this transaction.")
			If (OK=1)
				OrderLineReSetPrice
			End if 
		Else 
			OrderLineReSetPrice
		End if 
	End if 
End if 
vLineMod:=True:C214