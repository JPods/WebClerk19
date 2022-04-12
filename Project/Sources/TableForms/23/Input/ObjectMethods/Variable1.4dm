// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-18T00:00:00, 12:07:40
// ----------------------------------------------------
// Method: [PopUp].Input1.Variable1
// Description
// Modified: 08/18/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([PopupChoice:134])
	FIRST RECORD:C50([PopupChoice:134])
	For ($i; 1; $k)
		[PopupChoice:134]seq:6:=$i
		SAVE RECORD:C53([PopupChoice:134])
		NEXT RECORD:C51([PopupChoice:134])
	End for 
	UNLOAD RECORD:C212([PopupChoice:134])
	//  --  CHOPPED  AL_UpdateArrays(ePopupChoices; -2)
End if 