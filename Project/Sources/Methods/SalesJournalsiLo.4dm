//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 16:03:20
// ----------------------------------------------------
// Method: SalesJournalsiLo
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
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([SalesJournal:50]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[SalesJournal:50])
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
			
			
			Before_New(ptCurTable)  //last thing to do
		End if 
		//every cycle
		
		booAccept:=True:C214
	End if 
End if 
