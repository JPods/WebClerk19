Case of 
	: (Form event code:C388=On Load:K2:1)
		STR_TablesListBox("LB_Tables")
	: (Form event code:C388=On Clicked:K2:4)
		tableName:=Form:C1466.LB_Tables.cur.tableName
		aTableNums:=Form:C1466.LB_Tables.cur.tableNum
		STR_FieldsListBox
End case 