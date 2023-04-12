process_o.entry_o.taxJuris:=DE_PopUpArray(Self:C308)
vMod:=calcOrder(True:C214)
Copy_NewEntry(->[Customer:2]; ->[Order:3]taxJuris:43; ->[Customer:2]taxJuris:65)
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]taxJuris:43)