
// Modified by: Bill James (2022-11-19T06:00:00Z)
// Method: DataBrowser.pu_viewsList
// Description 
// Parameters
// ----------------------------------------------------



Case of 
	: (Form event code:C388=On Clicked:K2:4)
		LB_DataBrowser._popupViewSelected(aViewsList{aViewsList}; "aViewsList")
		Self:C308->:=Find in array:C230(Self:C308->; LB_DataBrowser.view)
	: (Form event code:C388=On Load:K2:1)
		
		
		
End case 

