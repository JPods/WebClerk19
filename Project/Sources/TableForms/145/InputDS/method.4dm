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
			If (Is new record:C668([QQQObjective:145]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[QQQObjective:145])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		// iLoRecordNew:=False  in Before_New
		//  iLoRecordChange:=false
		
		QUERY:C277([QQQResult:157]; [QQQResult:157]idUniqueObjective:2=[QQQObjective:145]idUnique:4)
		ORDER BY:C49([QQQResult:157]; [QQQResult:157]Priority:19)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 