If (InvcOkToChange)
	CM_ChangeWho(->[Invoice:26]repId:22; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aiExtPrice; ->aiExtCost; ->aiRepRate; ->aiRepComm; ->[Invoice:26]repCommission:28; ->aiQtyShip; ->aiLineAction)
	Copy_NewEntry(->[QQQCustomer:2]; ->[Invoice:26]repId:22; ->[QQQCustomer:2]repID:58)
Else 
	Self:C308->:=Old:C35(Self:C308->)
End if 
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; Self:C308)