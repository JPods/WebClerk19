//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/19/07, 15:14:34
// ----------------------------------------------------
// Method: QQSetPricePoint
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### jwm ### 20151214_1155
If (<>aTypeSale=0)
	<>aTypeSale:=1
End if 

If (<>vPricePoint#"")
	C_LONGINT:C283($w)
	$w:=Find in array:C230(<>aTypeSale; <>vPricePoint)
	If ($w>0)
		If (<>aTypeSale>0)
			If (<>aTypeSale{<>aTypeSale}#<>aTypeSale{$w})
				<>aTypeSale:=$w
				QQPricePointReSet
			End if 
		End if 
	End if 
	<>vPricePoint:=""
End if 