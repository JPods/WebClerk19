C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		
		iLo35String2:=theFields{aFieldLns{1}}
		
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		
		iLo35String2:=theFields{aFieldLns{1}}
		
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 
ALProEvt:=0