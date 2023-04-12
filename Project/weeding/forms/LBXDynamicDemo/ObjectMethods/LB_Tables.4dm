Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Form:C1466=Null:C1517)
			
		End if 
		var tableName : Text
		tableName:=process_o.dataClassName
		tableNumber:=STR_GetTableNumber(tableName)
		
		
		If (Form:C1466["LB_Fields"]=Null:C1517)
			Form:C1466.LB_Fields:=cs:C1710.listboxK.new("LB_Fields")
		End if 
		STR_TablesListBox("LB_Tables")
		STR_FieldsListBox("LB_Fields"; tableName)
		If (tableName="")
			tableName:="Customer"
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		tableName:=Form:C1466.LB_Tables.cur.tableName
		//aTableNums:=Form.LB_Tables.cur.tableNum
		STR_FieldsListBox("LB_Fields"; Form:C1466.LB_Tables.cur.tableName)
End case 