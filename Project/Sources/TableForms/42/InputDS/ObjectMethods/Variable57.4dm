process_o.entry_o.taxJuris:=DE_PopUpArray(Self:C308)

vMod:=calcProposal(True:C214)
Copy_NewEntry(->[Customer:2]; ->[Proposal:42]taxJuris:33; ->[Customer:2]taxJuris:65)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; ->[Proposal:42]taxJuris:33)