C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		If (Size of array:C274(aFieldLns)>1)
			aTmp20Str2:=3
		End if 
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 
ALProEvt:=0