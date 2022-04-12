C_LONGINT:C283($error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		If (Modified record:C314([Item:4]))
			SAVE RECORD:C53([Item:4])
		End if 
		If (Modified record:C314([ItemSpec:31]))
			SAVE RECORD:C53([ItemSpec:31])
		End if 
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
		If ((aLsDocType{aItemLines{1}}="") | (aLsDocType{aItemLines{1}}="s@") | (aLsDocType{aItemLines{1}}="@b@"))
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aLsItemNum{aItemLines{1}})
			Item_GetSpec
		Else 
			BEEP:C151
		End if 
		COPY ARRAY:C226(aItemLines; <>aItemLines)
		COPY ARRAY:C226(aLsSrRec; <>aLsSrRec)
	: (ALProEvt=2)
		If (Modified record:C314([Item:4]))
			SAVE RECORD:C53([Item:4])
		End if 
		If (Modified record:C314([ItemSpec:31]))
			SAVE RECORD:C53([ItemSpec:31])
		End if 
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
		COPY ARRAY:C226(aItemLines; <>aItemLines)
		COPY ARRAY:C226(aLsSrRec; <>aLsSrRec)
		$w:=Find in array:C230(<>aPrsName; <>aPrsName{<>aPrsName})
		If ($w>0)
			<>bQQAddItems:=True:C214
			POST OUTSIDE CALL:C329(<>aPrsNum{$w})
		End if 
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		AL_CmdAll(->aLsItemNum; ->aItemLines)
End case 
ALProEvt:=0