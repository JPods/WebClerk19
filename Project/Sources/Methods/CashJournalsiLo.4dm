//%attributes = {}
// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event

If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305($allowed)
	$allowed:=(UserInPassWordGroup("Archive"))
End if 

$formEvent:=iLoProcedure(->[CashJournal:52])
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

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): William James
	// Date and time: 2014-03-28T00:00:00, 16:07:19
	// ----------------------------------------------------
	// Method: CashJournalsiLo
	// Description
	// Modified: 03/28/14
	// Structure: CEv13_131005
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	C_POINTER:C301($ptLastTable)
	C_BOOLEAN:C305($fillFromPrevious; $doMore)
	C_LONGINT:C283($formEvent)
	$formEvent:=Form event code:C388
	If ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	Else 
		If ($formEvent=On Load:K2:1)
			If (UserInPassWordGroup("Archive"))
				If (vHere>1)  //coming from another table's input layout
					If (Is new record:C668([CashJournal:52]))
						$ptLastTable:=ptCurTable
						$fillFromPrevious:=True:C214
					End if 
				End if 
			End if 
			//
			C_LONGINT:C283($formEvent)
			$formEvent:=iLoProcedure(->[CashJournal:52])
			//
			$doMore:=False:C215
			Case of 
				: (iLoRecordNew)  //set in iLoProcedure only once
					
					$doMore:=True:C214
				: (iLoRecordChange)  //set in iLoProcedure only once
					
					$doMore:=True:C214
			End case 
			If ($doMore)
				Before_New(ptCurTable)  //last thing to do
			End if 
			//every cycle
			
			booAccept:=True:C214
		End if 
	End if 
	
End if 

