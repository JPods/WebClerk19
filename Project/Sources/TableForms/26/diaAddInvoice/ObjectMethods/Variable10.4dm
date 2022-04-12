//  CHOPPED  aCustCodes:=AL_GetLine(eOpenOrders)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		GOTO SELECTED RECORD:C245([Order:3]; aOrdRecs{aCustCodes})
		LOAD RECORD:C52([Order:3])
		If (Locked:C147([Order:3]))
			CONFIRM:C162("This order is locked by another user.  An invoice may not be created.")
		Else 
			vi1:=[Order:3]idNum:2
		End if 
	: (ALProEvt=2)
		GOTO SELECTED RECORD:C245([Order:3]; aOrdRecs{aCustCodes})
		LOAD RECORD:C52([Order:3])
		If (Locked:C147([Order:3]))
			CONFIRM:C162("This order is locked by another user.  An invoice may not be created.")
		Else 
			ONE RECORD SELECT:C189([Order:3])
			myOK:=1
			CANCEL:C270
		End if 
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
ALProEvt:=0