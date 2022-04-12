C_LONGINT:C283(bQQPull)

//QQItemAdd (<>aPrsNum{Current process})



C_LONGINT:C283($error)
//  CHOPPED  $error:=AL_GetSelect(eOrdList; aRayLines)
KeyModifierCurrent
If (OptKey=0)
	If (Size of array:C274(<>aLsSrRec)>0)
		<>bQQAddItems:=True:C214
		OutSide_Do
	End if 
	
Else 
	QQ_Push(->aoItemNum; ->aRayLines)
End if 