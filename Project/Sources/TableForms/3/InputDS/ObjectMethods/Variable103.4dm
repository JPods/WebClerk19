CONFIRM:C162("Changing sector changes the customer record.")
If (OK=1)
	entryEntity.sector:=DE_PopUpArray(Self:C308)
	[QQQCustomer:2]sector:124:=[Order:3]sector:138
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Invoice:26]sector:102)
End if 