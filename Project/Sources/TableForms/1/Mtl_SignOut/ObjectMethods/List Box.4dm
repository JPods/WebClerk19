C_LONGINT:C283($error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aWDItemLine; 0)
		//  CHOPPED  $error:=AL_GetSelect(eItemWd; aWDItemLine)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aWDItemLine; 0)
		//  CHOPPED  $error:=AL_GetSelect(eItemWd; aWDItemLine)
		ALProEvt:=0
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		AL_CmdAll(->aWdItemRec; ->aWDItemLine)
End case 
ALProEvt:=0