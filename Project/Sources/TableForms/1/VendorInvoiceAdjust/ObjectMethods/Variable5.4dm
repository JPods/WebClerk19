C_TEXT:C284($tempString)
ptCurTable:=(->[PO:39])
$tempString:=", Rcvd "+String:C10(aPOQtyRcvd{aPOLineAction})+" of BL "+String:C10(aPOQtyOrder{aPOLineAction})
diaItemXRef(->aPOItemNum{aPOLineAction}; ->aPODescpt{aPOLineAction}; $tempString; -aPOQtyRcvd{aPOLineAction})
ptCurTable:=(->[Control:1])