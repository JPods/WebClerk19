//dummy array so that aPLineAction won't get messed up by CM_AllLineCalc
ARRAY LONGINT:C221(aTempInt; Size of array:C274(aPLineAction))
[Proposal:42]salesCommission:10:=CM_AllLineCalc(<>tcSaleMar; Self:C308; ->aPExtPrice; ->aPExtCost; ->aPSalesRate; ->aPSaleComm; ->aPQtyOrder; ->aTempInt)
ARRAY LONGINT:C221(aTempInt; 0)