// ### jwm ### 20180101_0028  added dropdown <>aMachineName

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
			If (Is new record:C668([CronJob:82]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
				[CronJob:82]MachineName:22:="All Machines"
				
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[CronJob:82])
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
		
		<>aNameID:=1
		
		jDateTimeRecov([CronJob:82]DTLast:14; ->vDate1; ->vTime1)
		jDateTimeRecov([CronJob:82]DTNextEvent:20; ->vDate2; ->vTime2)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

