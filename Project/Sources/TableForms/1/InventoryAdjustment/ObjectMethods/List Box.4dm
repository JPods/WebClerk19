C_LONGINT:C283($error)
KeyModifierCurrent
If (CapKey=1)
	TRACE:C157
End if 
Case of 
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		ARRAY LONGINT:C221(aItemLines; 0)
		//  TRACE
		//  CHOPPED  $error:=AL_GetSelect(eItemList; aItemLines)
		//aItemLines{1}:=AL_GetLine (eItemList)//;aItemLines)
		//ALERT(String(aItemLines{1}))
		//aItemLines{1}:=aItemLines{1}
		If (Size of array:C274(aItemLines)>0)
			vPartNum:=aLsItemNum{aItemLines{1}}
			v1:=aLsItemNum{aItemLines{1}}
			v2:=aLsItemDesc{aItemLines{1}}
			If (aLsReason{aItemLines{1}}#"")
				v3:=aLsReason{aItemLines{1}}
			End if 
			vr1:=aLsQtyOH{aItemLines{1}}
			vr2:=aLSQtySO{aItemLines{1}}
			vr3:=aLsQtyPO{aItemLines{1}}
			vr4:=aLsCost{aItemLines{1}}
			GOTO OBJECT:C206(vr2)
		End if 
		//: (ALProEvt=2)
		//ARRAY LONGINT(aItemLines;0)
		////  CHOPPED  $error:=AL_GetSelect (eItemList;aItemLines)
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 