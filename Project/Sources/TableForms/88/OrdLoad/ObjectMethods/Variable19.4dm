Case of 
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		ARRAY LONGINT:C221(aLiLoadItemSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eLoadList; aLiLoadItemSelect)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(aLiLoadItemSelect)
		vR5:=0
		For ($i; 1; $k)
			vR5:=vR5+(aLiUnitWt{aLiLoadItemSelect{$i}}*aLiQty{aLiLoadItemSelect{$i}})
		End for 
		
		
		
	: (ALProEvt=-1)
	: (ALProEvt=-2)  //Edit menu Select All
		AL_CmdAll(->aLiRecordNum; ->aLiLoadItemSelect)
End case 
ALProEvt:=0