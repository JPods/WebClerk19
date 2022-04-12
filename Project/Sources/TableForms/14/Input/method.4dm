C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([TaxJurisdiction:14]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[TaxJurisdiction:14])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			booAccept:=False:C215
			READ ONLY:C145([DefaultAccount:32])
			GOTO RECORD:C242([DefaultAccount:32]; 0)
			[TaxJurisdiction:14]taxPayGLAcct:4:=[DefaultAccount:32]taxPayable:16
			UNLOAD RECORD:C212([DefaultAccount:32])
			READ WRITE:C146([DefaultAccount:32])
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		QUERY:C277([Territory:25]; [Territory:25]purpose:6=1; *)
		QUERY:C277([Territory:25];  & [Territory:25]territoryid:3=[TaxJurisdiction:14]taxJurisdiction:1)
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=([TaxJurisdiction:14]taxJurisdiction:1#"")
End if 

