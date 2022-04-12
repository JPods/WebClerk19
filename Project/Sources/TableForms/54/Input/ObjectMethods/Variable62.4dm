entryEntity.repID:=DE_PopUpArray(Self:C308)
//If (InvcOkToChange )
//CM_ChangeWho (->[InvoiceLine]RepID;-><>aReps;->[Rep];->vComRep;-><>aRepRate;<>tcSaleMar;->aiExtPrice;->aiExtCost;->aiRepRate;->aiRepComm;->[InvoiceLine]CommRep;->aiQtyShip;->aiLineAction)
//Copy_NewEntry (->[Customer];->[InvoiceLine]RepID;->[Customer]RepID)
//Else 
//[InvoiceLine]RepID:=Old([InvoiceLine]RepID)
//End if 
// zzzqqq U_DTStampFldMod(->[InvoiceLine:54]comment:40; ->[InvoiceLine:54]repID:34)