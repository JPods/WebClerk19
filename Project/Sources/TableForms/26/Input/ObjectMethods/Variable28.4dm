CONFIRM:C162("Changing sector changes the customer record.")
If (OK=1)
	entryEntity.sector:=DE_PopUpArray(Self:C308)
	[QQQCustomer:2]sector:124:=[Invoice:26]sector:102
	// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]sector:102)
End if 