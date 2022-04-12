C_LONGINT:C283($error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aRayLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eRptList; aRayLines)
		aBullets:=aRayLines{Size of array:C274(aRayLines)}
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aRayLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eRptList; aRayLines)
		aBullets:=aRayLines{Size of array:C274(aRayLines)}
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		AL_CmdAll(->aCustSales; ->aRayLines)
End case 
ALProEvt:=0