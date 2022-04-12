Case of 
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		ARRAY LONGINT:C221(aShipSel; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		doSearch:=2
	: (ALProEvt=-1)
	: (ALProEvt=-2)  //Edit menu Select All
		AL_CmdAll(->atrackID; ->aShipSel)
End case 
ALProEvt:=0