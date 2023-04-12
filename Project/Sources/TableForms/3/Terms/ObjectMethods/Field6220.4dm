Ln_ChangeNeedDate(->[Order:3])
If (Storage:C1525.default.dtStampFldMods)
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]dateShipOn:31)
End if 
CONFIRM:C162("Change ShipOn for selected lines?")
If (OK=1)
	$k:=Size of array:C274(aRayLines)
	For ($i; 1; $k)
		aoDateShipOn{aRayLines{$i}}:=[Order:3]dateShipOn:31
	End for 
End if 
