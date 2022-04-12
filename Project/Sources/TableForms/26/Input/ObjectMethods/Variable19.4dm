C_LONGINT:C283(bQQPull)
TRACE:C157
//QQItemAdd (<>aPrsNum{Current process})

KeyModifierCurrent
If (OptKey=0)
	If (Size of array:C274(<>aLsSrRec)>0)
		<>bQQAddItems:=True:C214
		OutSide_Do
	End if 
Else 
	QQ_Push(->aiItemNum; ->aRayLines)
End if 