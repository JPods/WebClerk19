KeyModifierCurrent
C_POINTER:C301($ptField)
$ptField:=(->[DInventory:36]UnitCost:7)
If (OptKey=0)
	ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->)
Else 
	ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; <)
End if 

