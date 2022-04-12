//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-03T00:00:00, 13:00:31
// ----------------------------------------------------
// Method: LN_GrossPerCent
// Description
// Modified: 06/03/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------


C_REAL:C285($newPrice)
KeyModifierCurrent
If (OptKey=1)
	
	pUnitCost:=Margin2Cost(pGross; pDscntPrice)
	
Else 
	// test 2018
	$newPrice:=Margin2Price(pGross; pUnitCost)
	//If (pUnitPrice=0)
	pDiscnt:=0
	pUnitPrice:=$newPrice
	//Else 
	//pDiscnt:=Round(1-($newPrice/pUnitPrice);8)*100
	//End if 
End if 