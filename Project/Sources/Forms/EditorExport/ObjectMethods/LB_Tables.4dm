Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Form:C1466=Null:C1517)
			
		End if 
		If (tableName="")
			tableName:=Form:C1466.dataClassName
			tableNumber:=STR_GetTableNumber(tableName)
		End if 
		If (Form:C1466["LB_Tables"]=Null:C1517)
			Form:C1466.LB_Tables:=cs:C1710.listboxK.new("LB_Tables")
			//Form.LB_Tables:=New object("ents"; New object; "cur"; New object; "sel"; New object; "pos"; -1)
		End if 
		If (Form:C1466["LB_Fields"]=Null:C1517)
			Form:C1466.LB_Fields:=cs:C1710.listboxK.new("LB_Fields")
			//Form.LB_Fields:=New object("ents"; New object; "cur"; New object; "sel"; New object; "pos"; -1)
		End if 
		STR_TablesListBox("LB_Tables")
		STR_FieldsListBox("LB_Fields"; tableName)
	: (Form event code:C388=On Clicked:K2:4)
		tableName:=Form:C1466.LB_Tables.cur.tableName
		aTableNums:=Form:C1466.LB_Tables.cur.tableNum
		STR_FieldsListBox("LB_Fields"; Form:C1466.LB_Tables.cur.tableName)
End case 