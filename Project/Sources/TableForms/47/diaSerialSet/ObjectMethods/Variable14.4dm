Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aSrRecSel; 0)
		//  CHOPPED  $err:=AL_GetSelect(eListSrNums; aSrRecSel)
		viRecordsInSelection:=Size of array:C274(aSrRecSel)
		If (myOK=15)  //searching
			GOTO RECORD:C242([ItemSerial:47]; aSrRecNum{aSrRecSel{1}})
			vSnItmAlpha:=[ItemSerial:47]itemNum:1
			vsnSrNum:=[ItemSerial:47]serialNum:4
		End if 
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aSrRecSel; 0)
		//  CHOPPED  $err:=AL_GetSelect(eListSrNums; aSrRecSel)
		//viRecordsInSelection:=Size of array(aSrRecSel)
		If (myOK=15)  //searching
			GOTO RECORD:C242([ItemSerial:47]; aSrRecNum{aSrRecSel{1}})
			vSnItmAlpha:=[ItemSerial:47]itemNum:1
			vsnSrNum:=[ItemSerial:47]serialNum:4
		End if 
		myOK:=2
		CANCEL:C270
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
C_LONGINT:C283($err)
ALProEvt:=0