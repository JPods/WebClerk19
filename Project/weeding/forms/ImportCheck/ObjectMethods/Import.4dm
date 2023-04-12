$myDoc:=Open document:C264(""; Read mode:K24:5)
If (OK=1)
	C_TEXT:C284($vtDoc)
	CLOSE DOCUMENT:C267($myDoc)
	$vtDoc:=Document to text:C1236(document)
	C_COLLECTION:C1488($cRecords; $cHeaders; $cRow; cSel)
	cSel:=New collection:C1472
	$cRecords:=New collection:C1472
	$cRecords:=Split string:C1554($vtDoc; "\r")
	C_TEXT:C284($vtRow; $vtFieldValue)
	C_LONGINT:C283($rowCounter; $viFieldCounter)
	C_OBJECT:C1216(obSel; $obRec)
	$rowCounter:=0
	For each ($vtRow; $cRecords)
		$rowCounter:=$rowCounter+1
		If ($rowCounter=1)
			$cHeaders:=Split string:C1554($vtRow; "\t")
			cSel.push($cHeaders)
		Else 
			$cRow:=Split string:C1554($vtRow; "\t")
			If (False:C215)
				$obRec:=New object:C1471
				$viFieldCounter:=0
				For each ($vtFieldValue; $cHeaders)
					$obRec[$cHeaders[$vtFieldValue]]:=New object:C1471
					$obRec[$cHeaders[$vtFieldValue]]:=$cRow[$vtFieldValue]
					$viFieldCounter:=$viFieldCounter+1
				End for each 
			End if 
			cSel.push($cRow)
		End if 
	End for each 
End if 

