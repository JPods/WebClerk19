Case of 
	: (Form event code:C388=On Load:K2:1)
		ALpLoadSets
		
	: (ALProEvt=0)
	: (ALProEvt=1)
		//  CHOPPED  $numSelect:=AL_GetLine(eFileList)
		aText4:=$numSelect
		vtSetName:=aText5{$numSelect}
		myOK:=5
		//  CHOPPED  AlpUpdateArea(eFileList; -2)
	: (ALProEvt=2)
		C_LONGINT:C283($numSelect)
		//  CHOPPED  $numSelect:=AL_GetLine(eFileList)
		aText4:=$numSelect
		
		ShowSet
		
End case 

ALProEvt:=0
