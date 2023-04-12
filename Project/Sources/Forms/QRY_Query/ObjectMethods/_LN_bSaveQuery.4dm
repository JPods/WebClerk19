If (qryDraft_o.queryString=Null:C1517)
	BEEP:C151
Else 
	CONFIRM:C162("Save draft query to TallyMaster.name: "+process_o.query.cur.name)
	If (OK=1)
		process_o.query.cur.obField:=qryDraft_o
		process_o.query.cur.save()
	End if 
End if 