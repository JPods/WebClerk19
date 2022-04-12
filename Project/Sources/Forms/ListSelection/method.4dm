
// Modified by: Bill James (2022-04-02T05:00:00Z)
// Method: ListSelection SF area
// Description 
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Load:K2:1)
		// does not work here but does work when called from the primary form On_Load
		//OBJECT SET SUBFORM(*; "SF_List"; "ListSelection")
		
		// this does not populate when called from the primary form
		// will populate when called from on_load in the LB
		//SF_List_Execute("_LB_OutputDS_")
End case 
