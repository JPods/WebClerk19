process_o.entryEntity.repID:=DE_PopUpArray(Self:C308)
CM_ChangeWho(->[Order:3]repID:8; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aORepRate; ->aORepComm; ->[Order:3]repCommission:9; ->aOQtyOrder; ->aoLineAction)
Copy_NewEntry(->[QQQCustomer:2]; ->[Order:3]repID:8; ->[QQQCustomer:2]repID:58)
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]repID:8)