If (InvcOkToChange)
	[Invoice:26]salesCommission:36:=CM_AllLineCalc(<>tcSaleMar; Self:C308; ->aiExtPrice; ->aiExtCost; ->aiSalesRate; ->aiSaleComm; ->aiQtyShip; ->aiLineAction)
Else 
	vComSales:=CM_FindRate(->[Invoice:26]salesNameID:23; -><>aComNameID; -><>aEmpRate)
End if 
