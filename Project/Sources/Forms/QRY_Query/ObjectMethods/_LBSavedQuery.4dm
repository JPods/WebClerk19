
Case of 
	: (process_o.query.ents#Null:C1517)
		
	: (Form event code:C388=On Clicked:K2:4)
		qryDraft_o:=choices_o.query.cur.obField
		
	: (Form event code:C388=On Double Clicked:K2:5)
		qryDraft_o:=choices_o.query.cur.obField
		
		If (qryDraft_o.inSelection)
			Form:C1466.ents:=Form:C1466.displayedSelection.query(qryDraft_o.queryString; qryDraft_o.queryParams)
		Else 
			Form:C1466.ents:=Form:C1466.dataClass.query(qryDraft_o.queryString; qryDraft_o.queryParams)
		End if 
		qryCount_i:=Form:C1466.ents.length
End case 
