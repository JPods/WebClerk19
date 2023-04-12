Case of 
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: (Form:C1466.dataClassName=Null:C1517)
				Form:C1466.dataClassName:="Customer"
			: (Form:C1466.dataClassName="")
				Form:C1466.dataClassName:="Customer"
		End case 
		
		var LB_Tables : cs:C1710.listboxTF
		Form:C1466["LB_Tables"]:=cs:C1710.listboxTF.new("LB_Tables"; Form:C1466.dataClassName)
		Form:C1466.LB_Tables.setTables()
		Form:C1466.LB_Tables.setSelected("tableName"; Form:C1466.dataClassName)
		
		var LB_Fields : cs:C1710.listboxTF
		Form:C1466["LB_Fields"]:=cs:C1710.listboxTF.new("LB_Fields"; Form:C1466.dataClassName)
		Form:C1466.LB_Fields.setFields()
		
		var LB_Show : cs:C1710.listboxTF
		Form:C1466["LB_Show"]:=cs:C1710.listboxTF.new("LB_Show"; Form:C1466.dataClassName)
		Form:C1466.LB_Show.setFields(New collection:C1472)
		
		//Form.LB_Fields.setSelected("tableName"; Form.dataClassName)
		
		// STR_TablesListBox("LB_Tables")
		//STR_FieldsListBox("LB_Fields"; tableName)
	: (Form event code:C388=On Clicked:K2:4)
		tableName:=Form:C1466.LB_Tables.cur.tableName
		aTableNums:=Form:C1466.LB_Tables.cur.tableNum
		STR_FieldsListBox("LB_Fields"; Form:C1466.LB_Tables.cur.tableName)
		
		If (Form:C1466.LB_Tables.cur.tableName#Form:C1466.dataClassName)
			// this should be added to a class for the DataBrowser
			Form:C1466.LB_Show.ents:=New collection:C1472
			If (LB_Show#Null:C1517)
				LB_Show.setData()
			End if 
			Form:C1466.dataClassName:=Form:C1466.LB_Tables.cur.tableName
			
			LB_Import.setFCtoForm(aViewsList{aViewsList})
			
			
		End if 
End case 