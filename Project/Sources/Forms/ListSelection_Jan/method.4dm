
// Modified by: Bill James (2022-04-02T05:00:00Z)
// Method: ListSelection SF area
// Description 
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Data Change:K2:15)
		Case of 
			: ((Form:C1466.dt.begin.date#dateBegin_d) | (Form:C1466.dt.end.date#dateEnd_d))
				Form:C1466.dt.begin.date:=dateBegin_d
				//Form.queryActionChoices(dateBegin_d; 
				
		End case 
		
End case 
