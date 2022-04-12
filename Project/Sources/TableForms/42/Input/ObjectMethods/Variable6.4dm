//C_Longint($curLine)
//GOTO AREA(pQtyOrd)
//PpLnInsertRay(vlineCnt;1;1)
//PpLnFillVar (1)
//SetAreaArrays (ePropList;aPUse;aPQtyOrder;aPItemNum;aPDescpt;aPUnitPrice
//;aPDiscnt;aPUnitCost;aPExtPrice;aPLineAction)
//ItemSetButtons (aPLineAction;True;False)
KeyModifierCurrent
If (OptKey=1)
	ListItemsLrScrn(ptCurTable; pPartNum)
Else 
	HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
End if 