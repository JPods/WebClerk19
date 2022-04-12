entryEntity.taxJuris:=DE_PopUpArray(Self:C308)

vMod:=calcProposal(True:C214)
Copy_NewEntry(->[QQQCustomer:2]; ->[Proposal:42]taxJuris:33; ->[QQQCustomer:2]taxJuris:65)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; ->[Proposal:42]taxJuris:33)