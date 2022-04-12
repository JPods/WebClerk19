//Method: OM:  b43
//Noah Dykoski   September 3, 2001 / 9:14 PM
//copies the bom cost to the item cost
CONFIRM:C162("Apply calculated to CostAverage")
If (OK=1)
	[Item:4]costAverage:13:=vrBOMCostStandard
End if 