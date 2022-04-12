// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/05/10, 15:01:51
// ----------------------------------------------------
// Method: Object Method: PriceBase
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (([SpecialDiscount:44]PriceBase:8<1) | ([SpecialDiscount:44]PriceBase:8>5))
	ALERT:C41("Default Price Level must be set for 1 to 4.")
	[SpecialDiscount:44]PriceBase:8:=1
End if 