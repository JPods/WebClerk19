// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/29/06, 15:19:31
// ----------------------------------------------------
// Method: Object Method: iLoInteger1
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($contactID)
If ([Service:6]contactID:52>0)
	$contactID:=[Service:6]contactID:52
	PUSH RECORD:C176([Service:6])
	QUERY:C277([Service:6]; [Service:6]contactID:52=$contactID)
	If (Records in selection:C76([Service:6])>0)
		ProcessTableOpen(Table:C252(->[Service:6])*-1)
	Else 
		ALERT:C41("No other Service Records for this contact.")
	End if 
	POP RECORD:C177([Service:6])
Else 
	ALERT:C41("No contactID in Service Record.")
End if 