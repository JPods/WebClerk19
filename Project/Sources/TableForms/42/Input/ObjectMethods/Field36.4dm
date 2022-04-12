//dummy array so that aPLineAction won't get messed up by CM_AllLineCalc
ARRAY LONGINT:C221(aTempInt; Size of array:C274(aPLineAction))
CM_ChangeWho(->[Proposal:42]repID:7; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aPExtPrice; ->aPExtCost; ->aPRepRate; ->aPRepComm; ->[Proposal:42]repCommission:8; ->aPQtyOrder; ->aTempInt)
ARRAY LONGINT:C221(aTempInt; 0)
Copy_NewEntry(->[QQQCustomer:2]; ->[Proposal:42]repID:7; ->[QQQCustomer:2]repID:58)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; Self:C308)