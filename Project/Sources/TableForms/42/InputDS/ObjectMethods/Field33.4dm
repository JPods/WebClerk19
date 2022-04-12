// zzzqqq PopUpWildCard(->[Proposal:42]typeSale:20; -><>aTypeSale; ->[PopUp:23])
DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Proposal:42]typeSale:20; [Proposal:42]dateNeeded:4)
Copy_NewEntry(->[Customer:2]; ->[Proposal:42]typeSale:20; ->[Customer:2]typeSale:18)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; Self:C308)
pPricePt:=[Proposal:42]typeSale:20
CONFIRM:C162("Update selected lines TypeSale and Item Pricing")
If (OK=1)
	//If ([Proposal]TimesPrinted#0)
	//CONFIRM("Account for existing printed copies of this transaction.")
	If (OK=1)
		ProposalLinesResetPrice
	End if 
	//End if 
End if 

