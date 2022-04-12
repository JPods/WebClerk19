C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([CommunicationDevice:63]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[CommunicationDevice:63])
	//
	Case of 
		: (iLoRecordChange)
			
		: (iLoRecordNew)  //set in iLoProcedure only once
			If ($fillFromPrevious)
				If ($ptLastTable=(->[Lead:48]))
					[CommunicationDevice:63]customerID:1:=String:C10([Lead:48]idNum:32)
					[CommunicationDevice:63]tableNum:2:=Table:C252(->[Lead:48])
				Else 
					[CommunicationDevice:63]customerID:1:=[Customer:2]customerID:1
					[CommunicationDevice:63]tableNum:2:=Table:C252(->[Customer:2])
				End if 
			End if 
			OBJECT SET ENTERABLE:C238([CommunicationDevice:63]customerID:1; True:C214)
			OBJECT SET ENTERABLE:C238([CommunicationDevice:63]tableNum:2; True:C214)
			Before_New(ptCurTable)  //last thing to do
		: (iLoRecordChange)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
	End case 
	//
End if 