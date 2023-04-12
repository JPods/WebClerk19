If (False:C215)
	//Date: 03/15/02
	//Who: Dan Bentson, Arkware
	//Description: added
	VERSION_960
End if 

C_LONGINT:C283(bSelectLine)  //first element is the sizing array, second element is the controlling array

//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
If (Size of array:C274(aItemLines)>0)
	If (Size of array:C274(aLsItemNum)>0)
		Ray_ShowSubSet(->aItemLines; ->aLsDocType; ->aLsItemNum; ->aLsItemDesc; ->aLsQtyOH; ->aLsQtySO; ->aLsQtyPO; ->aLsLeadTime; ->aLsPrice; ->aLsDiscount; ->aLsDiscountPrice; ->aLsCost; ->aLSMargin; ->aLsDate; ->aLsText1; ->aLsText2; ->aLsSrRec)  //;->aLsItemChild)
		Ray_SetSize(Size of array:C274(aItemLines); ->aLsDocType; ->aLsItemNum; ->aLsItemDesc; ->aLsQtyOH; ->aLsQtySO; ->aLsQtyPO; ->aLsLeadTime; ->aLsPrice; ->aLsDiscount; ->aLsDiscountPrice; ->aLsCost; ->aLSMargin; ->aLsDate; ->aLsText1; ->aLsText2; ->aLsSrRec)  //;->aLsItemChild)
		//  --  CHOPPED  AL_UpdateArrays(eQuickQuote; -2)
	End if 
End if 