$doChange:=UserInPassWordGroup("ChangesalesNameID")
If (($doChange) | (Is new record:C668([Customer:2])))
	entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
	//this is the problem
	If (InvcOkToChange)
		CM_ChangeWho(->[Invoice:26]salesNameID:23; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aiExtPrice; ->aiExtCost; ->aiSalesRate; ->aiSaleComm; ->[Invoice:26]salesCommission:36; ->aiQtyShip; ->aiLineAction)
	Else 
		[Invoice:26]salesNameID:23:=Old:C35([Invoice:26]salesNameID:23)
	End if 
	Copy_NewEntry(->[Customer:2]; ->[Invoice:26]salesNameID:23; ->[Customer:2]salesNameID:59)
	// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]salesNameID:23)
End if 
