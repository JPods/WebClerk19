
// Modified by: Bill James (2022-03-30T05:00:00Z)
// Method: OutputDS.SF_List
// Description 
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		//OBJECT SET SUBFORM(*; "SF_List"; "ListSelection")
		// does not populate when called here
		//SF_List_Execute("_LB_OutputDS_")
		
End case 