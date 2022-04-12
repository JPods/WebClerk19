C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aMatchLine; 0)
		//  CHOPPED  $error:=AL_GetSelect(eMatchList; aMatchLine)
		aMatchType:=aMatchLine{1}
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eMatchList; aMatchLine)
		aMatchType:=aMatchLine{1}
	: ((ALProEvt=-5) | (ALProEvt=-1) | (ALProEvt=-6))  //Sort Button //Sort Editor//Line has been dragged  //User invoked Sort Editor 
		
		
	: (ALProEvt=-2)
		AL_CmdAll(->aMatchField; ->aCntMatFlds)  // array of values in the areaList, selected array
		
		If (False:C215)
			C_LONGINT:C283($inc; $sizeCounterRay)
			$sizeCounterRay:=Size of array:C274(aMatchField)
			ARRAY LONGINT:C221(aCntMatFlds; $sizeCounterRay)
			For ($inc; 1; $sizeCounterRay)
				aCntMatFlds{$inc}:=$inc
			End for 
		End if 
		
		//  --  CHOPPED  AL_UpdateArrays(eMatchList; Size of array(aCntMatFlds))
End case 
ALProEvt:=0