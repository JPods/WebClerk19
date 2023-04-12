Case of 
	: (Form event code:C388=On Header Click:K2:40)
		Case of 
			: (Right click:C712)
				LB_DataBrowser._popupRightClick()
			: ((Windows Ctrl down:C562) | (Macintosh command down:C546))  // 
				LB_DataBrowser._popupControlClick()
			: (Shift down:C543)  // change views
				LB_DataBrowser._popupShiftClick()
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		// azxLearning by: Bill James (2023-02-26T06:00:00Z)
		// conflicts between listbox.cur and process_o.cur
		entry_o:=process_o.listClick()
		
		
		
	: (Form event code:C388=On Load:K2:1)
		// does not work, use process_o
		//If (Form.dataClassName=Null)
		//Form.dataClassName:=process_o.dataClassName
		//End if 
		
		//var LB_DataBrowser : cs.listboxk
		
		LB_DataBrowser:=cs:C1710.listboxK.new("LB_DataBrowser"; Form:C1466.dataClassName)
		//
		//LB_Selection_s:=cs.listboxStructure.new("LB_Selection"; "Customer")
		// re
		//LB_DataBrowser.setColumns()
		
		process_o.setData()
End case 