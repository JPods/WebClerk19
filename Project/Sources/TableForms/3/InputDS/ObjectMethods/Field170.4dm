If ([Customer:2]shippingDays:22>0)
	[Order:3]dateShipOn:31:=[Order:3]dateNeeded:5-[Customer:2]shippingDays:22
End if 
Ln_ChangeNeedDate(->[Order:3])
If (Storage:C1525.default.dtStampFldMods)
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]dateNeeded:5)
End if 