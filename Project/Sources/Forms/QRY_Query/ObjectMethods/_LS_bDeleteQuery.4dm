If (process_o.query.cur=Null:C1517)
	BEEP:C151
Else 
	CONFIRM:C162("Delete query from TallyMaster.name: "+process_o.query.cur.name)
	If (OK=1)
		choices_o.query.cur.drop()
		choices_o.getQueries()
	End if 
End if 