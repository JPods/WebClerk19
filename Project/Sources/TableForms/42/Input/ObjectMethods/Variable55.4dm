//KeyModifierCurrent 
//$doLineChange:=False
//If (CmdKey=1)
//$doLineChange:=true
//End if 
entryEntity.typeSale:=DE_PopUpArray(Self:C308)
DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Proposal:42]typeSale:20; [Proposal:42]dateNeeded:4)
Copy_NewEntry(->[Customer:2]; ->[Proposal:42]typeSale:20; ->[Customer:2]typeSale:18)
// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; ->[Proposal:42]typeSale:20)

//C_Longint($tempBase;$i)
//C_REAL($price)
//If ((Size of array(aPPLnSelect)>2)|($doLineChange))

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

