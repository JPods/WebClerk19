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
			If (Is new record:C668([ItemSerialAction:64]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[ItemSerialAction:64])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			[ItemSerialAction:64]SerialNum:2:=[ItemSerial:47]SerialNum:4
			[ItemSerialAction:64]ItemSerialID:1:=[ItemSerial:47]idUnique:18
			//[ItemSrlAction]FileRef:=
			//[ItemSrlAction]DocID:=
			[ItemSerialAction:64]ItemNum:8:=[ItemSerial:47]ItemNum:1
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		C_TEXT:C284(vsSrlDocTp)
		vsSrlDocTp:=<>aTableNames{[ItemSerialAction:64]tableNum:3}
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 