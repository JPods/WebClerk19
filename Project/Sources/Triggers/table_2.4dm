// Trigger for [anyTable]
//TRACE
If ([Customer:2]customerID:1="")
	[Customer:2]customerID:1:=String:C10(CounterNew("Customer"))
End if 
If (False:C215)
	C_LONGINT:C283($0)
	C_BOOLEAN:C305($doSave)
	$doSave:=False:C215
	$0:=0  // Assume the database request will be granted
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			// Perform appropriate action for the saving of a newly created record
			$doSave:=True:C214
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			// Perform appropriate actions for the saving of an already existing record
			$doSave:=True:C214
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			// Perform appropriate actions for the deletion of a record
	End case 
	
	If ($doSave)
		KeyWordsMake(->[Customer:2])
	End if 
	
	If (False:C215)
		<>aLastRecNum{Table:C252(ptCurTable)}:=Record number:C243(ptCurTable->)
		booAccept:=True:C214  // ### jwm ### 20190711_1408 start with accept = true, no errors found
		
		If (RecordAcceptTest(booAccept; ptCurTable))  //jStartup0  
			
			If (Is new record:C668([Customer:2]))
				TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
			End if 
			Data_ArchiveOld
			
			// ### jwm ### 20171207_1106 updated [Contact]DateRetired
			If ([Customer:2]dateRetired:111#Old:C35([Customer:2]dateRetired:111))
				AcceptContactsRetired
			End if 
			
			acceptFilePt($unLoad; ->[Customer:2]; ->[Contact:13]; ->[Service:6]; ->[Reference:7]; ->[Call:34])
			acceptFilePt($unLoad; ->[OrderLine:49]; ->[Order:3]; ->[Invoice:26]; ->[Proposal:42]; ->[InvoiceLine:54])
			
			If ([Customer:2]mfrLocationid:67<-1999999)
				$processNum:=New process:C317("setChMfgs"; <>tcPrsMemory; "ChoiceArray")
			End if 
			
		End if 
	End if 
End if 