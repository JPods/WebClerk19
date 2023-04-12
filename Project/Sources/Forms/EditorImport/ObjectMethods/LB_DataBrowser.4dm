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
		
		SF_cur.setSource()
		// we may want an autoSave before changing data
		// SF_cur.cur:=LB_DataBrowser.cur
		
	: (Form event code:C388=On Load:K2:1)
		
End case 