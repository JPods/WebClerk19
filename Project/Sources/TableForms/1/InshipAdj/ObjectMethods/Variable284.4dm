// method to open the PO receipt entry from for a record in the entry stack

If (Size of array:C274(aStkSelect)<1)
	// problem
	ALERT:C41("Please select a record to edit the POReceipt information")
Else 
	If (Size of array:C274(aStkSelect)>1)
		ALERT:C41("Please select only 1 record to edit the POReceipt information")
	Else 
		// only 1 record is selected    
		QUERY:C277([POReceipt:95]; [POReceipt:95]idUnique:1=aStkReceiptID{aStkSelect{1}})
		If (Records in selection:C76([POReceipt:95])=1)
			$createdReceipt:=PORcpt_OpenEntryForm
			
			If ($createdReceipt=1)
				SAVE RECORD:C53([POReceipt:95])
			End if 
			
			UNLOAD RECORD:C212([POReceipt:95])
		Else 
			ALERT:C41("No receipt records were found")
		End if 
	End if 
End if 