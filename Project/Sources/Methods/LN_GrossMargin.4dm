//%attributes = {"publishedWeb":true}
If (False:C215)
	//01/21/03.prf
	//Added option key to re-calculate cost instead of price
	VERSION_9919
	VERSION_9919_ISC
End if 
C_REAL:C285($newPrice; $unitMargin)
KeyModifierCurrent
If (pQtyOrd#0)
	$unitMargin:=pGrossMar/pQtyOrd
	
	If (OptKey=1)
		
		pUnitCost:=pDscntPrice-$unitMargin
		
	Else 
		
		$newPrice:=$unitMargin+pUnitCost
		pGross:=Margin4Price($newPrice; pUnitCost)
		If (pUnitPrice=0)
			pDiscnt:=0
			pUnitPrice:=$newPrice
		Else 
			pDiscnt:=Round:C94(1-($newPrice/pUnitPrice); 8)*100
		End if 
		
	End if 
	
Else 
	$unitMargin:=0
	pGrossMar:=0
	pGross:=0
End if 
