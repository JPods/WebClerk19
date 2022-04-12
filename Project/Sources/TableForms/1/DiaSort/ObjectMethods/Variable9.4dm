C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		doSearch:=2
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 
ALProEvt:=0