Case of 
	: (Form event code:C388=On Load:K2:1)
		// Form seems to be created from the Dialog command passing a parameter
		If (tableName="")
			tableName:="Customer"
			tableNumber:=2
		End if 
		If (Form:C1466["LB_Tables"]=Null:C1517)
			Form:C1466.LB_Tables:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1)
		End if 
		If (Form:C1466["LB_Fields"]=Null:C1517)
			Form:C1466.LB_Fields:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1)
		End if 
		STR_TablesListBox("LB_Tables")
		STR_FieldsListBox("LB_Fields"; tableName)
	: (Form event code:C388=On Clicked:K2:4)
		tableName:=Form:C1466.LB_Tables.cur.tableName
		aTableNums:=Form:C1466.LB_Tables.cur.tableNum
		STR_FieldsListBox("LB_Fields"; Form:C1466.LB_Tables.cur.tableName)
End case 