C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: ($formEvent=On Load Record:K2:38)
		//UNLOAD RECORD(ptCurTable->)
	Else 
		If ($formEvent=On Load:K2:1)
			If (vHere>1)  //coming from another table's input layout
				If (Is new record:C668([ItemSerial:47]))
					$ptLastTable:=ptCurTable
					$fillFromPrevious:=True:C214
				End if 
			End if 
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[ItemSerial:47])
		//
		$doMore:=False:C215
		Case of 
			: (iLoRecordNew)  //set in iLoProcedure only once
				[ItemSerialAction:64]serialNum:2:=[ItemSerial:47]serialNum:4
				[ItemSerialAction:64]itemSerialid:1:=[ItemSerial:47]idNum:18
				//[ItemSrlAction]FileRef:=
				//[ItemSrlAction]DocID:=
				[ItemSerialAction:64]itemNum:8:=[ItemSerial:47]itemNum:1
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once
				
				$doMore:=True:C214
		End case 
		If ($doMore)
			REDUCE SELECTION:C351([Customer:2]; 0)
			REDUCE SELECTION:C351([Contact:13]; 0)
			REDUCE SELECTION:C351([Vendor:38]; 0)
			REDUCE SELECTION:C351([Service:6]; 0)
			If ([ItemSerial:47]customerID:9#"")
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ItemSerial:47]customerID:9)
			End if 
			If ([ItemSerial:47]contactid:30>0)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=[ItemSerial:47]contactid:30)
				QUERY:C277([Service:6]; [Service:6]contactid:52=[ItemSerial:47]contactid:30)
			End if 
			If ([ItemSerial:47]vendorID:5#"")
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[ItemSerial:47]vendorID:5)
			End if 
			Before_New(ptCurTable)  //last thing to do
		End if 
		//every cycle
		
		booAccept:=True:C214
End case 


