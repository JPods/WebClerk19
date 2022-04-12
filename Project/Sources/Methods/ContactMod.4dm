//%attributes = {"publishedWeb":true}
KeyModifierCurrent
If (optkey=0)
	If (Size of array:C274(aContact)>0)
		C_LONGINT:C283($k)
		$k:=Records in selection:C76([Contact:13])
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactUnique{aContact})  // Replaced GOTO Record in Selection
		MODIFY RECORD:C57([Contact:13])
		If ($k=Records in selection:C76([Contact:13]))
			//  CHOPPED  ContactsLoad(Records in selection([Contact]))
		Else 
			REDUCE SELECTION:C351([Contact:13]; 0)
			//  CHOPPED  ContactsLoad(-1)
		End if 
	Else 
		BEEP:C151
	End if 
Else 
	If (Size of array:C274(aShipTo)>0)
		C_LONGINT:C283($k)
		$k:=Records in selection:C76([Contact:13])
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=aShipToUnique{aShipTo})
		MODIFY RECORD:C57([Contact:13])
		If ($k=Records in selection:C76([Contact:13]))
			//  CHOPPED  ContactsLoad(Records in selection([Contact]))
		Else 
			REDUCE SELECTION:C351([Contact:13]; 0)
			//  CHOPPED  ContactsLoad(-1)
		End if 
	Else 
		BEEP:C151
	End if 
End if 