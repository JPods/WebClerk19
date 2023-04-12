
// Modified by: Bill James (2022-03-30T05:00:00Z)
// Method: OutputDS.SF_List
// Description 
// Parameters
// ----------------------------------------------------

Case of 
		
	: (Form event code:C388=On Bound Variable Change:K2:52)
		
		process_o:=OBJECT Get subform container value:C1785
		
	: (Form event code:C388=On Data Change:K2:15)
		
		OBJECT SET SUBFORM CONTAINER VALUE:C1784(process_o)
		
	: (Form event code:C388=On Load:K2:1)
		//OBJECT SET SUBFORM CONTAINER VALUE(process_o)
		//call subform container
		//Execute Method in Subform
		// change this command
		//  https://developer.4d.com/docs/FormObjects/subformOverview/#synchronizing-parent-form-and-subform-multiple-values
		
		// process_o and Form should be the identical reference
		
		//Form.fieldList:=""
		
		// azxLearning by: Bill James (2023-03-31T05:00:00Z)
		// should be set in process_o class
		//If (process_o.source=Null)
		//process_o.setSource(ds[process_o.dataClassName].all())
		//End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		
End case 