$doChange:=UserInPassWordGroup("ChangesalesNameID")
If (($doChange) | (Is new record:C668([Customer:2])))
	entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
	CM_ChangeWho(->[Order:3]salesNameID:10; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aOSalesRate; ->aOSaleComm; ->[Order:3]salesCommission:11; ->aOQtyOrder; ->aoLineAction)
	Copy_NewEntry(->[Customer:2]; ->[Order:3]salesNameID:10; ->[Customer:2]salesNameID:59)
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]salesNameID:10)
End if 