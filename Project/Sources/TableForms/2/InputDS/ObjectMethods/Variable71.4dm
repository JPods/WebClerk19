//Customer Shipping page, Script: <>aShipVia
KeyModifierCurrent
If ((CmdKey=1) & (OptKey=1))
	TRACE:C157
	CONFIRM:C162("Move contacts to customer records with similar acct codes.")
	If (OK=1)
		Contact2Cust
	End if 
Else 
	entryEntity.shipVia:=DE_PopUpArray(Self:C308)
	Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteid:106)
End if 