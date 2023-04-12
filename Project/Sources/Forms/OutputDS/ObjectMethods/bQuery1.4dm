

process_o.entitySave()

//Form.ents:=process_o.ents
//Form.sel:=process_o.sel
If (False:C215)
	Form:C1466.dataClass:=ds:C1482[process_o.dataClassName]
	Form:C1466.dataClassName:=process_o.dataClassName
	If (Form:C1466.queryTable=Null:C1517)
		Form:C1466.queryTable:=New object:C1471("path"; "")
	End if 
	If (Form:C1466.queryTable.inSelection=Null:C1517)
		Form:C1466.queryTable.inSelection:=False:C215  // query does not have to be done in the selection
	End if 
	// 4D_25Invoice - 2022-01-15
	Form:C1466.queryTable.path:="_ANYWHERE_"
End if 
//If (process_o.ents=Null)
//Form.ents:=Form.dataClass.all()
//Else 

//End if 

//QQQ_ClassReplace
// Form.ents:=QRY_Do_Query(ds; Form.dataClass; Form.ents; Form.queryTable.inSelection)

If (process_o.query.inSelection=Null:C1517)
	process_o.queryTable:=New object:C1471("inSelection"; Form:C1466.ck_CurrentSel)
End if 
//var $changed_b : Boolean
//$changed_b:=QRY_Do_Query(ds; \
process_o.dataClass; \
process_o.ents)
process_o.ents:=QRY_Do_Query(ds:C1482; process_o.dataClassName; process_o.ents; process_o.queryTable.inSelection)
//If ($changed_b)
//entry_o:=process_o.selectChanged()
//End if 

//action_Search


//OutputFormSearch