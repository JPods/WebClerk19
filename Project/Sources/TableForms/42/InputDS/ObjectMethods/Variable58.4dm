process_o.entry_o.repID:=DE_PopUpArray(Self:C308)
//dummy array so that aPLineAction won't get messed up by CM_AllLineCalc
ARRAY LONGINT:C221(aTempInt; Size of array:C274(aPLineAction))
CM_ChangeWho(->[Proposal:42]repID:7; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aPExtPrice; ->aPExtCost; ->aPRepRate; ->aPRepComm; ->[Proposal:42]repCommission:8; ->aPQtyOrder; ->aTempInt)
ARRAY LONGINT:C221(aTempInt; 0)
Copy_NewEntry(->[Customer:2]; ->[Proposal:42]repID:7; ->[Customer:2]repID:58)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; ->[Proposal:42]repID:7)