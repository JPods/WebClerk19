CONFIRM:C162("Changing sector changes the customer record.")
If (OK=1)
	entryEntity.sector:=DE_PopUpArray(Self:C308)
	[QQQCustomer:2]sector:124:=[Proposal:42]sector:88
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Proposal:42]sector:88)
End if 