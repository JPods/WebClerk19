entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
//dummy array so that aPLineAction won't get messed up by CM_AllLineCalc
ARRAY LONGINT:C221(aTempInt; Size of array:C274(aPLineAction))
CM_ChangeWho(->[Proposal:42]salesNameID:9; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aPExtPrice; ->aPExtCost; ->aPSalesRate; ->aPSaleComm; ->[Proposal:42]salesCommission:10; ->aPQtyOrder; ->aTempInt)
ARRAY LONGINT:C221(aTempInt; 0)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; ->[Proposal:42]salesNameID:9)