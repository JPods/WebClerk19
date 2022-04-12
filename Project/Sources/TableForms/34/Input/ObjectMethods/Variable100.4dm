C_LONGINT:C283($error; $incLines; $cntLines)
Case of 
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=-2))
		C_REAL:C285($balance)
		C_LONGINT:C283(eContactsCallReports)
		ARRAY LONGINT:C221(aContactsSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eContactsCallReports; aContactsSelect)
		GOTO RECORD:C242([Contact:13]; aContactsRecordNum{aContactsSelect{1}})
		If ([CallReport:34]tableNum:2=2)
			[CallReport:34]contactID:44:=[Contact:13]idNum:28
		End if 
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aContactsSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eContactsCallReports; aContactsSelect)
		GOTO RECORD:C242([Contact:13]; aContactsRecordNum{aContactsSelect{1}})
		
		ProcessTableOpen(Table:C252(->[Contact:13])*-1)
		
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
ALProEvt:=0