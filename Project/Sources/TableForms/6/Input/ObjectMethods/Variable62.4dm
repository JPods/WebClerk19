KeyModifierCurrent
Case of 
	: (CmdKey=1)
		entryEntity.ActionCreatedBy:=DE_PopUpArray(Self:C308)
	: (OptKey=1)
		entryEntity.actionBy:=DE_PopUpArray(Self:C308)
	Else 
		entryEntity.repID:=DE_PopUpArray(Self:C308)
End case 
// zzzqqq U_DTStampFldMod(->[Service:6]comment:11; ->[Service:6]repID:2)