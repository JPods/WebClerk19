
// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: [Control].diaListChoice
// Description 
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_LONGINT:C283($error)
		C_LONGINT:C283(ePopList)
		C_TEXT:C284(v35diaStr1)
		//    
	: (Form event code:C388=On Outside Call:K2:11)
		Prs_OutsideCall
		
End case 