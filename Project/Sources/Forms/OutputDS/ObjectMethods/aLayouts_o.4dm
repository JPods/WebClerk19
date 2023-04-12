
// Modified by: Bill James (2022-04-02T05:00:00Z)
// Method: oLoButtonBar.aActions
// Description 
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (aLayouts{aLayouts}="Selection")
				OBJECT SET SUBFORM:C1138(*; "SF_List"; "DataBrowser")
			: (aLayouts=2)
				//skip
			Else 
				OBJECT SET SUBFORM:C1138(*; "SF_List"; "List"+aLayouts{aLayouts})
		End case 
		
	: (Form event code:C388=On Load:K2:1)
		
End case 

