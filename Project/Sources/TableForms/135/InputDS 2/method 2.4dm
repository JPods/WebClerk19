C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[CounterPending:135])
	
	
	Case of 
		: (iLoReturningToLayout)
			iLoReturningToLayout:=False:C215
		: (iLoRecordNew)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
		: (iLoRecordChange)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
	End case 
	
	
End if 