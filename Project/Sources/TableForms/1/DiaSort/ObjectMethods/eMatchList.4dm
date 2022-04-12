C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aMatchLine; 0)
		//  CHOPPED  $error:=AL_GetSelect(eMatchList; aMatchLine)
		If (Size of array:C274(aMatchLine)>0)
			aMatchType:=aMatchLine{1}
		End if 
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aMatchLine; 0)
		//  CHOPPED  $error:=AL_GetSelect(eMatchList; aMatchLine)
		If (Size of array:C274(aMatchLine)>0)
			aMatchType:=aMatchLine{1}
			If (aMatchType{aMatchLine{1}}="A")
				aMatchType{aMatchLine{1}}:="D"
			Else 
				aMatchType{aMatchLine{1}}:="A"
			End if 
			Sort_Build
		End if 
	: ((ALProEvt=-5) | (ALProEvt=-1) | (ALProEvt=-6))  //Sort Button //Sort Editor//Line has been dragged  //User invoked Sort Editor 
		
		C_LONGINT:C283($inc; $sizeCounterRay)
		$sizeCounterRay:=Size of array:C274(aMatchField)
		ARRAY LONGINT:C221(aCntMatFlds; $sizeCounterRay)
		For ($inc; 1; $sizeCounterRay)
			aCntMatFlds{$inc}:=$inc
		End for 
		Sort_Build
End case 
ALProEvt:=0
If (eMatchList>0)
	//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
End if 