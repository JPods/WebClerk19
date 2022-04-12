C_TEXT:C284($tempString)
KeyModifierCurrent
If (OptKey=0)
	$tempString:=", Ship "+String:C10(aiQtyShip{aiLineAction})+" of BL "+String:C10(aiQtyRemain{aiLineAction})
	diaItemXRef(->aiItemNum{aiLineAction}; ->aiDescpt{aiLineAction}; $tempString; aiQtyShip{aiLineAction})
	
	
Else 
	
	
End if 