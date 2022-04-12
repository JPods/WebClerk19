Folder_ContentToDocs
If (process_o.cur.idNumTask=Null:C1517)
	LB_Document.ents:=ds:C1482.Document.query("customerID = :1 & idNumTask < 9"; process_o.cur.customerID)
Else 
	LB_Document.ents:=ds:C1482.Document.query("idNumTask = :1"; process_o.cur.idNumTask)
End if 