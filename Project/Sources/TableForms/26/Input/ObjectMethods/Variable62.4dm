entryEntity.repId:=DE_PopUpArray(Self:C308)
If (InvcOkToChange)
	CM_ChangeWho(->[Invoice:26]repId:22; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aiExtPrice; ->aiExtCost; ->aiRepRate; ->aiRepComm; ->[Invoice:26]repCommission:28; ->aiQtyShip; ->aiLineAction)
	Copy_NewEntry(->[QQQCustomer:2]; ->[Invoice:26]repId:22; ->[QQQCustomer:2]repID:58)
Else 
	[Invoice:26]repId:22:=Old:C35([Invoice:26]repId:22)
End if 
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]repId:22)