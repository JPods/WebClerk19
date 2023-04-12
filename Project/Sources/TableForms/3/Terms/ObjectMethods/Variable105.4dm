process_o.entry_o.customerPO:=DE_PopUpArray(Self:C308)

//If ((<>tcbManyType)&([Customer]customerID#""))
//DscntSetPrice (->[Invoice]TypeSale;<>ptInvoiceDateFld)
//Else 
//DscntSpecialClr (->[Invoice]TypeSale)
//End if 
vMod:=True:C214
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]customerPO:3)
