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
			If (Is new record:C668([QQQCurrency:61]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[QQQCurrency:61])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			[QQQCurrency:61]DTCreated:1:=jDateTimeEnter
			vDate1:=Current date:C33
			[QQQCurrency:61]Active:2:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			jDateTimeRecov([QQQCurrency:61]DTCreated:1; ->vDate1; ->vTime1)
	End case 
	If ($doMore)
		If ([QQQCurrency:61]ExchangeRate:4=0)
			[QQQCurrency:61]ExchangeRate:4:=1
		Else 
			vrLo1:=Round:C94(1/[QQQCurrency:61]ExchangeRate:4; [QQQCurrency:61]ConvertPrec:7)
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
End if 

