//iloInteger1:=0
//bSkipWkEnd:=1
//bFixbyDays:=1
//jDaysWork (->iloInteger1;->bSkipWkEnd;->bFixbyDays;->[Order]ShipOnDate;->[Order]DateNeeded;[Customer]ShippingDays;3)
[Order:3]dateShipOn:31:=ShipOnDate([Order:3]dateNeeded:5; [Customer:2]shippingDays:22)
Ln_ChangeNeedDate(->[Order:3])
If (Storage:C1525.default.dtStampFldMods)
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]dateNeeded:5)
End if 
