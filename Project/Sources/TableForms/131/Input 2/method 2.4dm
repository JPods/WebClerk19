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
			If (Is new record:C668([CustomerXRef:131]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[CustomerXRef:131])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
		: (iLoRecordChange)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
	End case 
	If ($doMore)
		
		
		
		
	End if 
	booAccept:=True:C214
End if 