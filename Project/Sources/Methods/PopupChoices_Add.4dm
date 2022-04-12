//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/09/17, 15:27:29
// ----------------------------------------------------
// Method: PopupChoices_Add
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($selected)
If ((viVert<=0) | (viVert>Records in selection:C76([PopupChoice:134])))
	viVert:=1
End if 
viVert:=Records in selection:C76([PopupChoice:134])+1

[PopUp:23]approvedOn:2:=[PopUp:23]approvedOn:2
CREATE RECORD:C68([PopupChoice:134])

[PopupChoice:134]arrayName:1:=[PopUp:23]arrayName:3
SAVE RECORD:C53([PopupChoice:134])
QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=[PopUp:23]arrayName:3)
//ORDER BY([PopupChoice];[PopupChoice]Choice)
//  --  CHOPPED  AL_UpdateArrays(ePopupChoices; -2)
// -- AL_SetLine(ePopupChoices; viVert)
// -- AL_SetScroll(ePopupChoices; viVert; viHorz)
GOTO OBJECT:C206(ePopupChoices)
//  --  CHOPPED  AL_GotoCell(ePopupChoices; viVert; viHorz)