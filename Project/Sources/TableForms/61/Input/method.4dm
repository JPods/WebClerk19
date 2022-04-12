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
			If (Is new record:C668([Currency:61]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Currency:61])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			[Currency:61]dtCreated:1:=DateTime_Enter
			vDate1:=Current date:C33
			[Currency:61]active:2:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			jDateTimeRecov([Currency:61]dtCreated:1; ->vDate1; ->vTime1)
	End case 
	If ($doMore)
		If ([Currency:61]exchangeRate:4=0)
			[Currency:61]exchangeRate:4:=1
		Else 
			vrLo1:=Round:C94(1/[Currency:61]exchangeRate:4; [Currency:61]convertPrec:7)
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
End if 

