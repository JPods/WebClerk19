//F2
KeyModifierCurrent
If (ShftKey=0)
	If ((Size of array:C274(aPItemNum)>=aPLineAction) & (aPLineAction>0))
		List_FlowOnHand(eItemPp; ->aPItemNum{aPLineAction})  //open ords & PO, this itemp
	End if 
Else 
	If (Size of array:C274(aItemLines)>0)
		If (Size of array:C274(aLsSrRec)>=aItemLines{1})
			List_FlowOnHand(eItemPp; ->aLsItemNum{aItemLines{1}})  //Last 5 inship
		End if 
	End if 
End if 
