$doChange:=UserInPassWordGroup("ChangesalesNameID")
If (($doChange) | (Is new record:C668([Customer:2])))
	entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
	//this is the problem
	//If (InvcOkToChange )
	//CM_ChangeWho (->[InvoiceLine]SalesName;-><>aComNameID;->[Employee];->vComSales;-><>aEmpRate;<>tcSaleMar;->aiExtPrice;->aiExtCost;->aiSalesRate;->aiSaleComm;->[InvoiceLine]CommSales;->aiQtyShip;->aiLineAction)
	//Copy_NewEntry (->[Customer];->[InvoiceLine]SalesName;->[Customer]SalesName)
	//Else 
	//[InvoiceLine]SalesName:=Old([InvoiceLine]SalesName)
	//End if 
	// zzzqqq U_DTStampFldMod(->[InvoiceLine:54]comment:40; ->[InvoiceLine:54]salesNameID:35)
End if 
