C_TEXT:C284($tempString)

$tempString:=", Ord "+String:C10(aOQtyOrder{aoLineAction})+" BL "+String:C10(aOQtyBL{aoLineAction})
diaItemXRef(->aOItemNum{aoLineAction}; ->aODescpt{aoLineAction}; $tempString; aOQtyBL{aoLineAction})
