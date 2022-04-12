//Script: eQList
C_LONGINT:C283($error)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aQQLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eQList; aQQLns)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aQQLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eQList; aQQLns)
		doSearch:=-3
End case 
ALProEvt:=0