$doChange:=UserInPassWordGroup("ChangesalesNameID")
If (($doChange) | (Is new record:C668([Customer:2])))
	entry_o.salesNameID:=DE_PopUpArray(Self:C308)
	// zzzqqq U_DTStampFldMod(->[Customer:2]comment:15; ->[Customer:2]salesNameID:59)
End if 