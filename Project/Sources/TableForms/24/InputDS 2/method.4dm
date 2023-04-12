
// ### jwm ### 20181214_1543 check this or restore old procedure
// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[Project:24])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		[Project:24]projectNum:1:=CounterNew(->[Project:24])
		[Project:24]dateStarted:10:=Current date:C33
		[Project:24]active:3:=True:C214
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	srCustomer:=[Project:24]company:14
	srAcct:=[Project:24]customerid:4
	// related records not addressed by (P) RelatedGet
	// form calculations
	
	JobsGetRelatedRecords
	If ([Project:24]customerid:4="")
		FontSrchLabels(1)
	Else 
		FontSrchLabels(3)
	End if 
	
End if 

booAccept:=True:C214  // no madatory fields




C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	
	//
	
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		
		srCustomer:=[Project:24]company:14
		srAcct:=[Project:24]customerid:4
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 


