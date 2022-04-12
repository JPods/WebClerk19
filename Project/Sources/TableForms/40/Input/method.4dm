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
			If (Is new record:C668([QQQPOLine:40]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[QQQPOLine:40])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		booAccept:=True:C214
		If ([QQQPOLine:40]poNum:1#[PO:39]poNum:5)
			QUERY:C277([PO:39]; [PO:39]poNum:5=[QQQPOLine:40]poNum:1)
		End if 
		If ([QQQVendor:38]VendorID:1#[PO:39]vendorId:1)
			QUERY:C277([QQQVendor:38]; [QQQVendor:38]VendorID:1=[PO:39]vendorId:1)
		End if 
		srCustomer:=[QQQVendor:38]Company:2
		srPhone:=[QQQVendor:38]Phone:10
		srAcct:=[QQQVendor:38]VendorID:1
		srZip:=[QQQVendor:38]Zip:8
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

