If (InvcOkToChange)
	CM_ChangeWho(->[Invoice:26]salesNameID:23; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aiExtPrice; ->aiExtCost; ->aiSalesRate; ->aiSaleComm; ->[Invoice:26]salesCommission:36; ->aiQtyShip; ->aiLineAction)
Else 
	Self:C308->:=Old:C35(Self:C308->)
End if 
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; Self:C308)