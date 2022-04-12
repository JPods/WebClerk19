If (Size of array:C274(aItemLines)>0)
	Ray_ShowSubSet(->aItemLines; ->aPartNum; ->aPartDesc; ->aCosts; ->aQtySold; ->aQtyOrd; ->aQtyOnPOLns; ->aQtyOnHand; ->aLeadTime; ->aFactor)
	doSearch:=6
Else 
	BEEP:C151
	BEEP:C151
End if 