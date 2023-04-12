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
			
			
			If (Storage:C1525.user.role=Null:C1517)
				
			End if 
			$input_o:=New object:C1471(\
				"purpose"; Current form name:C1298; \
				"dataClassName"; Form:C1466.dataClassName; \
				"role"; Storage:C1525.user.role; \
				"name"; "LB_Databrowser")
			Form:C1466.fc:=New object:C1471
			Form:C1466.fc:=STR_FCGet($input_o)
			
			var SF_cur; LB_DataBrowser : Object
			If (Form:C1466.dataClassName=Null:C1517)
				Form:C1466.dataClassName:="Customer"
			End if 
			LB_DataBrowser:=cs:C1710.listboxK.new("LB_DataBrowser"; Form:C1466.dataClassName)
			If (Form:C1466.data=Null:C1517)
				Form:C1466.data:=ds:C1482[Form:C1466.dataClassName].all()
			End if 
			LB_DataBrowser.setSource(Form:C1466.data)
			
			SF_cur:=cs:C1710.cEntry.new(Form:C1466.dataClassName; "DataBrowser"; "SF_cur")
			SF_cur._setSubForm()  // space between fields
			//SF_cur._makeEntryChoices()  // build the external popup
			SF_cur.cur:=LB_DataBrowser.cur
			
			
			
			
			// LBX_DataBrowserSetTable(Form.dataClassName)
			//thisForm.setFCtoForm(aViewsList{aViewsList})
		End if 
End case 