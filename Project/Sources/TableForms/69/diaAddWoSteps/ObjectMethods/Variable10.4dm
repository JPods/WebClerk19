//Script: eWoStepList
C_LONGINT:C283($error)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aWoStepLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eWoStepList; aWoStepLns)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aWoStepLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eWoStepList; aWoStepLns)
		doSearch:=-3
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		CONFIRM:C162("Change Step Sequence?")
		If (OK=1)
			For ($i; 1; Size of array:C274(aWsSeq))
				aWsSeq{$i}:=$i
				GOTO RECORD:C242([WOTemplate:69]; aWsRecNum{$i})
				[WOTemplate:69]seq:11:=$i
				SAVE RECORD:C53([WOTemplate:69])
			End for 
			WO_FillStepRays(-6)
			UNLOAD RECORD:C212([WOTemplate:69])
			doSearch:=1
		End if 
End case 
ALProEvt:=0