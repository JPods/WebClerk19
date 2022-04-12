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
			If (Is new record:C668([Forum:80]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Forum:80])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			
			[Forum:80]dtUser:14:=DateTime_Enter
			[Forum:80]dtSubmitted:6:=[Forum:80]dtUser:14
			[Forum:80]dateEntered:9:=Current date:C33
			[Forum:80]timeEntered:10:=Current time:C178
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		
		jDateTimeRecov([Forum:80]dtUser:14; ->vDate1; ->vTime1)
		booAccept:=True:C214
		$doChange:=(UserInPassWordGroup("UnlockRecord"))
		If (Not:C34($doChange))
			OBJECT SET ENTERABLE:C238([TallyResult:73]publish:36; False:C215)
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
	booAccept:=True:C214
End if 

