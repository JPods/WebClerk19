C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aImportLine; 0)
		//  CHOPPED  $error:=AL_GetSelect(eImportList; aImportLine)
		aImportLine:=aImportLine{1}
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eImportList; aImportLine)
		aImportLine:=aImportLine{1}
	: ((ALProEvt=-5) | (ALProEvt=-1) | (ALProEvt=-6))  //Sort Button //Sort Editor//Line has been dragged  //User invoked Sort Editor 
		
End case 
ALProEvt:=0