KeyModifierCurrent
C_POINTER:C301($ptField)
$ptField:=(->[BOM:21]ItemNum:1)
If (OptKey=0)
	ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->)
Else 
	ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; <)
End if 

