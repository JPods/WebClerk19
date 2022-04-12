TRACE:C157
CONFIRM:C162("Combine POReceipts into first record")
If (OK=1)
	vi2:=Records in selection:C76([POReceipt:95])
	CONFIRM:C162("NO UNDO to combine "+String:C10(vi2)+" POReceipts")
	If (OK=1)
		SELECTION TO ARRAY:C260([POReceipt:95]; $aPOReceiptRec; [POReceipt:95]idUnique:1; $aPOReceiptID)
		FIRST RECORD:C50([POReceipt:95])
		vi2eyReceiptID:=[POReceipt:95]idUnique:1
		READ WRITE:C146([InventoryStack:29])
		For (vi1; 2; vi2)
			GOTO RECORD:C242([POReceipt:95]; $aPOReceiptRec{vi1})
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]ReceiptID:16=[POReceipt:95]idUnique:1)
			vi4:=Records in selection:C76([InventoryStack:29])
			FIRST RECORD:C50([InventoryStack:29])
			For (vi3; 1; vi4)
				[InventoryStack:29]ReceiptID:16:=vi2eyReceiptID
				SAVE RECORD:C53([InventoryStack:29])
				NEXT RECORD:C51([InventoryStack:29])
			End for 
			DELETE RECORD:C58([POReceipt:95])
		End for 
	End if 
End if 

If (False:C215)
	If (OK=1)
		vi2:=Records in selection:C76([POReceipt:95])
		CONFIRM:C162("NO UNDO to combine "+String:C10(vi2)+" POReceipts")
		If (OK=1)
			SELECTION TO ARRAY:C260([POReceipt:95]; $aPOReceiptRec; [POReceipt:95]idUnique:1; $aPOReceiptID)
			FIRST RECORD:C50([POReceipt:95])
			vi2eyReceiptID:=[POReceipt:95]idUnique:1
			READ WRITE:C146([InventoryStack:29])
			For (vi1; 2; vi2)
				GOTO RECORD:C242([POReceipt:95]; $aPOReceiptRec{vi1})
				QUERY:C277([InventoryStack:29]; [InventoryStack:29]ReceiptID:16=[POReceipt:95]idUnique:1)
				vi4:=Records in selection:C76([InventoryStack:29])
				FIRST RECORD:C50([InventoryStack:29])
				For (vi3; 1; vi4)
					[InventoryStack:29]ReceiptID:16:=vi2eyReceiptID
					SAVE RECORD:C53([InventoryStack:29])
					NEXT RECORD:C51([InventoryStack:29])
				End for 
				DELETE RECORD:C58([POReceipt:95])
			End for 
		End if 
	End if 
	
	ALERT:C41("Set to Jrnl Stacks")
	READ WRITE:C146([InventoryStack:29])
	ALL RECORDS:C47([InventoryStack:29])
	vi2:=Records in selection:C76([InventoryStack:29])
	FIRST RECORD:C50([InventoryStack:29])
	For (vi1; 1; vi2)
		[InventoryStack:29]JrnlComplete:13:=False:C215
		SAVE RECORD:C53([InventoryStack:29])
		NEXT RECORD:C51([InventoryStack:29])
	End for 
	
	
	//
	ALERT:C41("Multi Receipts per Vendor Invoice")
	ALL RECORDS:C47([POReceipt:95])
	vi2:=Records in selection:C76([POReceipt:95])
	SELECTION TO ARRAY:C260([POReceipt:95]; aTmpLong1; [POReceipt:95]VendorInvoiceNum:4; aTmp35Str1)
	SORT ARRAY:C229(aTmp35Str1; aTmpLong1)
	READ WRITE:C146([InventoryStack:29])
	vText1:="aqewragvaergaerrytggtghdrth"
	For (vi1; 1; vi2)
		If (vText1=aTmp35Str1{vi1})
			GOTO RECORD:C242([POReceipt:95]; aTmpLong1{vi1})
			[POReceipt:95]Comment:9:="Multi Receipts for Vendor Invoice"
			SAVE RECORD:C53([POReceipt:95])
			QUERY:C277([POReceipt:95]; [POReceipt:95]idUnique:1=[InventoryStack:29]ReceiptID:16)
			vi4:=Records in selection:C76([InventoryStack:29])
			FIRST RECORD:C50([InventoryStack:29])
			For (vi3; 1; vi4)
				[InventoryStack:29]Comment:7:="No PO Receipt"
				[InventoryStack:29]JrnlComplete:13:=True:C214
				[InventoryStack:29]JrnlID:25:=-5
				SAVE RECORD:C53([InventoryStack:29])
				NEXT RECORD:C51([InventoryStack:29])
			End for 
			vi9:=vi1-1
			If (vi8=0)
				GOTO RECORD:C242([POReceipt:95]; aTmpLong1{vi9})
				[POReceipt:95]Comment:9:="Multi Receipts for Vendor Invoice"
				SAVE RECORD:C53([POReceipt:95])
				vi8:=1
				QUERY:C277([POReceipt:95]; [POReceipt:95]idUnique:1=[InventoryStack:29]ReceiptID:16)
				vi4:=Records in selection:C76([InventoryStack:29])
				FIRST RECORD:C50([InventoryStack:29])
				For (vi3; 1; vi4)
					[InventoryStack:29]Comment:7:="No PO Receipt"
					[InventoryStack:29]JrnlComplete:13:=True:C214
					[InventoryStack:29]JrnlID:25:=-5
					SAVE RECORD:C53([InventoryStack:29])
					NEXT RECORD:C51([InventoryStack:29])
				End for 
			End if 
		Else 
			vText1:=aTmp35Str1{vi1}
			vi8:=0
		End if 
	End for 
End if 
