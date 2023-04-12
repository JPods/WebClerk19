Case of 
	: (Form event code:C388=On Header Click:K2:40)
		If (Right click:C712)
			var $select_i : Integer
			//LB_Selection_s.getPopup()
			LB_DataBrowser.getPopup()
			// LBX_RightClickHeader
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		
		entry_o:=process_o.listClick()
		
		
		
	: (Form event code:C388=On Load:K2:1)
		// does not work, use process_o
		//If (Form.dataClassName=Null)
		//Form.dataClassName:=process_o.dataClassName
		//End if 
		
		var LB_DataBrowser : cs:C1710.listboxk
		LB_DataBrowser.listboxk.new()
		//LB_Selection_s:=cs.listboxStructure.new("LB_Selection"; "Customer")
		LB_DataBrowser.setColumns()
		//LB_DataBrowser.setColumns()
		process_o.setData()
End case 