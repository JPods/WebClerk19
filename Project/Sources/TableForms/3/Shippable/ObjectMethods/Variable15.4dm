C_LONGINT:C283($error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eMarginList; aItemLines)
		aPartNum:=aItemLines{Size of array:C274(aItemLines)}
	: (ALProEvt=2)
		CANCEL:C270
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
ALProEvt:=0