C_TEXT:C284($tempString)
$tempString:=", Proposed "+String:C10(aPQtyOrder{aPLineAction})
diaItemXRef(->aPItemNum{aPLineAction}; ->aPDescpt{aPLineAction}; $tempString; aPQtyOrder{aPLineAction})