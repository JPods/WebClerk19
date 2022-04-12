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
			If (Is new record:C668([Letter:20]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		$formEvent:=iLoProcedure(->[Letter:20])
	End if 
	//
	C_LONGINT:C283($formEvent)
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		iLoRecordChange:=False:C215
		iLoRecordNew:=False:C215
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	booAccept:=True:C214
End if 
