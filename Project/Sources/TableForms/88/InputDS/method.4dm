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
			If (Is new record:C668([LoadTag:88]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[LoadTag:88])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		QUERY:C277([LoadItem:87]; [LoadItem:87]LoadTagID:8=[LoadTag:88]idUnique:1)
		
		iLoDate1:=jDateTimeRDate([LoadTag:88]DTAssembly:9)
		iLoDate2:=jDateTimeRDate([LoadTag:88]DTShipOn:10)
		iLoDate3:=jDateTimeRDate([LoadTag:88]DTCustoms:11)
		iLoDate4:=jDateTimeRDate([LoadTag:88]DTReceiveExpected:12)
		
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

