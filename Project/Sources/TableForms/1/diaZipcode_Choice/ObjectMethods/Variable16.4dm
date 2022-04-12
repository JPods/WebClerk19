Case of 
	: (ALProEvt=0)  //no action
		
	: (ALProEvt=1)  // single click
		//  CHOPPED  aZipCity:=AL_GetLine(eZipChoice)
		
	: (ALProEvt=2)  //double click
		//  CHOPPED  aZipCity:=AL_GetLine(eZipChoice)
		myOK:=1
		CANCEL:C270
		
End case 
ALProEvt:=0