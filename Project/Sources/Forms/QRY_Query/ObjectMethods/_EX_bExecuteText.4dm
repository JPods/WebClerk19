
//qryDraft_o:=QRY_ReturnObject
$inSelection:=qryDraft_o.inSelection
$queryString:=qryDraft_o.queryString
$queryParams:=qryDraft_o.queryParams

If ($inSelection)
	Form:C1466.ents:=Form:C1466.displayedSelection.query($queryString; $queryParams)
Else 
	Form:C1466.ents:=Form:C1466.dataClass.query($queryString; $queryParams)
End if 
qryCount_i:=Form:C1466.ents.length
choices_o.query.last:=qryDraft_o