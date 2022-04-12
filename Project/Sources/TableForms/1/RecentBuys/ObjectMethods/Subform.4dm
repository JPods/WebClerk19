C_LONGINT:C283($error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eItemOrd; aItemLines)
		aLsItemNum:=aItemLines{Size of array:C274(aItemLines)}
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eItemOrd; aItemLines)
		ALProEvt:=0
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		AL_CmdAll(->aLsSrRec; ->aItemLines)
End case 
ALProEvt:=0