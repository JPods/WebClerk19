
// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
C_BOOLEAN:C305($doMore)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[Catalog:102])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
		
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
	
End if 

booAccept:=True:C214  // no madatory fields


