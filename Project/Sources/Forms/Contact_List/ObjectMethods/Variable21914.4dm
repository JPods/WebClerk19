KeyModifierCurrent
If (CmdKey=1)
	If (Locked:C147([QQQCustomer:2]))
		jAlertMessage(12009)
	Else 
		If (Size of array:C274(aContactsSelect)>0)
			If (aContactsSelect{1}<=Size of array:C274(aContactsRecordNum))
				CONFIRM:C162("Change Primary Ship To")
				If (OK=1)
					[QQQCustomer:2]contactShipTo:93:=aContactsUniqueID{aContactsSelect{1}}
				End if 
			End if 
		End if 
	End if 
Else 
	Contact_ModifyByUnique(->[QQQCustomer:2]contactShipTo:93)
End if 
