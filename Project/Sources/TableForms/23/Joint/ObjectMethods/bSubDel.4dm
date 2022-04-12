
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/09/17, 15:25:53
// ----------------------------------------------------
// Method: [PopUp].Input1.Variable6
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (Form:C1466.PopupChoiceCurrent.id#Null:C1517)
	C_OBJECT:C1216($obRec)
	$obRec:=ds:C1482.PopupChoice.query("id = :1 "; Form:C1466.PopupChoiceCurrent.id).first()
	C_OBJECT:C1216($obStatus)
	$obStatus:=$obRec.drop()
	Case of 
		: ($obStatus.success)
			ConsoleMessage("You have dropped PopupChoice "+Form:C1466.PopupChoiceCurrent.choice)  //The dropped entity remains in memory
			Form:C1466.cPopupChoice.remove(Form:C1466.PopupChoicePosition-1)
		: ($obStatus.status=dk status stamp has changed:K85:20)
			ALERT:C41($status.statusText)
	End case 
End if 