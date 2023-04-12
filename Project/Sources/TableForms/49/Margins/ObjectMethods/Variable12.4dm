C_LONGINT:C283($i; $k; $w)
If ((aoLineAction>0) & (aOQtyShip{aoLineAction}=0))
	If ([Order:3]flow:134=2)
		ALERT:C41("Orders converted to bulk management cannot delete lines.")
	Else 
		$k:=Size of array:C274(aRayLines)
		For ($i; $k; 1; -1)
			If (aoUniqueID{aRayLines{$i}}>-1)
				$w:=Size of array:C274(aoLinesDelete)+1
				INSERT IN ARRAY:C227(aoLinesDelete; $w; 1)
				aoLinesDelete{$w}:=aoUniqueID{aRayLines{$i}}
			End if 
			OrdLn_RaySize(-1; aRayLines{$i}; 1)  //aiLineAction;1)//
		End for 
		//  OrdLn_RaySize (-1;aoLineAction;1)
		aoLineAction:=Ray_ReturnElem(->aoLineAction)
		curLines:=Size of array:C274(aoLineAction)
		Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
		vLineMod:=True:C214
		ItemSetButtons((Size of array:C274(aoLineAction)>0); True:C214)
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 
HIGHLIGHT TEXT:C210(pPartNum; 1; 255)