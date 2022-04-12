If (Form event code:C388=On Clicked:K2:4)
	C_OBJECT:C1216($obRec)
	C_COLLECTION:C1488($cTemp)
	$cTemp:=New collection:C1472
	C_TEXT:C284($vtFieldName)
	For each ($obRec; Form:C1466.fieldNamesItems)
		//If (Form.cQuery.length>0)
		//$cTemp.push(New object("Combine"; "AND")
		//Else 
		//$cTemp.Combine.push("")
		//End if 
		//$cTemp.push(New object("FieldFunction"; $obRec.fieldName)
		//$cTemp.push(New object("Compare"; "=")
		
	End for each 
	
	Form:C1466.cQuery:=$cTemp
End if 