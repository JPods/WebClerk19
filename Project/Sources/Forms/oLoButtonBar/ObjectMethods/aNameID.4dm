process_o.entitySave()
If (process_o.cur.actionBy#Null:C1517)
	Form:C1466.ents:=ds:C1482[process_o.dataClassName].query("actionBy = :1"; Self:C308->{Self:C308->})
Else 
	ALERT:C41("No ActionBy field")
End if 