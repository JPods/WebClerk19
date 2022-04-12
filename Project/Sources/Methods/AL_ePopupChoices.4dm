//%attributes = {}

// Modified by: Bill James (2022-01-23T06:00:00Z)
// Method: AL_ePopupChoices
// Description 
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($error; $incLines; $cntLines; $selected)

Case of 
	: (ALProEvt=-2)
	: (ALProEvt=-1)
	: (ALProEvt=0)
	: (ALProEvt=1)
		//Single Click
		
		//  CHOPPED  $selected:=AL_GetLine(ePopupChoices)
		GOTO SELECTED RECORD:C245([PopupChoice:134]; $selected)
		
		//  CHOPPED  AL_UpdateFields(ePopupChoices; -2)
	: (ALProEvt=2)
		//double Click
		////  CHOPPED  AL_UpdateFields (ePopupChoices;-2)
End case 
ALProEvt:=0
