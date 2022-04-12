
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/01/20, 17:24:33
// ----------------------------------------------------
// Method: [QACustomer].Input
// Description
// ### bj ### 20200101_1724
// Reworked Layout
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
			If (Is new record:C668([QACustomer:70]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[QACustomer:70])
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
		// make sure image is empty
		CLEAR VARIABLE:C89(vItemPict)
		vImagePath:=[QACustomer:70]photo:19
		If (vImagePath#"")
			// do not open the dialog box to select a picture if there is no path
			IE_GetPict(vImagePath; ->vItemPict)
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 