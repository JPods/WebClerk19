C_LONGINT:C283($i; $k)
Case of 
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		//  CHOPPED  aProOrRec:=AL_GetLine(eProfileIv)
	: (ALProEvt=-2)  //Edit menu Select All
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		$k:=Size of array:C274(aProOrSeq)
		For ($i; 1; $k)
			aProOrSeq{$i}:=$i
		End for 
		vMod:=True:C214
		//  --  CHOPPED  AL_UpdateArrays(eProfileIv; -2)
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0