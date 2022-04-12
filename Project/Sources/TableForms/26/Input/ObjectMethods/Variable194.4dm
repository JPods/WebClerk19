entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
If (InvcOkToChange)
	CM_ChangeWho(->[Invoice:26]salesNameID:23; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aiExtPrice; ->aiExtCost; ->aiSalesRate; ->aiSaleComm; ->[Invoice:26]salesCommission:36; ->aiQtyShip; ->aiLineAction)
Else 
	[Invoice:26]salesNameID:23:=Old:C35([Invoice:26]salesNameID:23)
	BEEP:C151
	BEEP:C151
End if 
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]salesNameID:23)