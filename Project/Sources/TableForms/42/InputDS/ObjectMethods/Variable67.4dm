//F4
KeyModifierCurrent
If (ShftKey=0)
	If ((Size of array:C274(aPItemNum)>=aPLineAction) & (aPLineAction>0))
		List_InvLines(eItemPp; ->aPItemNum{aPLineAction})  //Last 5 buys of this itemp
	End if 
Else 
	If (Size of array:C274(aItemLines)>0)
		If (Size of array:C274(aLsSrRec)>=aItemLines{1})
			List_InvLines(eItemPp; ->aLsItemNum{aItemLines{1}})  //Last 5 inship
		End if 
	End if 
End if 

If (eItemPp>0)
	//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
End if 