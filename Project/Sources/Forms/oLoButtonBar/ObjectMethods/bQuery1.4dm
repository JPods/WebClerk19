



//Form.ents:=process_o.ents
//Form.sel:=process_o.sel
Form:C1466.dataClass:=ds:C1482[process_o.tableName]
Form:C1466.dataClassName:=process_o.tableName
If (Form:C1466.queryTable=Null:C1517)
	Form:C1466.queryTable:=New object:C1471("path"; "")
End if 
If (Form:C1466.queryTable.inSelection=Null:C1517)
	Form:C1466.queryTable.inSelection:=False:C215  // query does not have to be done in the selection
End if 
// 4D_25Invoice - 2022-01-15
Form:C1466.queryTable.path:="_ANYWHERE_"
If (Form:C1466.ents=Null:C1517)
	Form:C1466.ents:=Form:C1466.dataClass.all()
End if 

Form:C1466.ents:=QRY_Do_Query(ds:C1482; Form:C1466.dataClass; Form:C1466.ents; Form:C1466.queryTable.inSelection)

If (OK=1)
	Form:C1466.queryTable.queryString:=""
End if 
//action_Search


//OutputFormSearch