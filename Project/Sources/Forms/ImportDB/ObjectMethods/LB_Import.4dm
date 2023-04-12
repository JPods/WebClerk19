Case of 
	: (Form event code:C388=On Header Click:K2:40)
		Case of 
			: (Right click:C712)
				LB_Import._popupRightClick()
			: ((Windows Ctrl down:C562) | (Macintosh command down:C546))  // 
				LB_Import._popupControlClick()
			: (Shift down:C543)  // change views
				LB_Import._popupShiftClick()
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		//SF_cur.setSource()
		// display the interal record if one exisits
		
		
	: (Form event code:C388=On Load:K2:1)
		
End case 