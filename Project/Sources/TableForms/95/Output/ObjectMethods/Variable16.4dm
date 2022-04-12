TRACE:C157
READ WRITE:C146([InventoryStack:29])
FIRST RECORD:C50([POReceipt:95])
vi2:=Records in selection:C76([POReceipt:95])
For (vi1; 1; vi2)
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]ReceiptID:16=[POReceipt:95]idUnique:1)
	vi9:=Records in selection:C76([InventoryStack:29])
	vR1:=Sum:C1([InventoryStack:29]ExtendedCost:17)
	vR2:=[POReceipt:95]VendorInvoiceAmount:7-vR1
	vR3:=Abs:C99(vR2)
	Case of 
		: (vi9<1)
			// ALERT("No Stacks: "+String([POReceipt]ReceiptID))
			[POReceipt:95]Comment:9:="No Stacks for this PO Receipt"
			[POReceipt:95]StackValues:10:=0
			SAVE RECORD:C53([POReceipt:95])
		: (vR3<0.2)
			FIRST RECORD:C50([InventoryStack:29])
			LOAD RECORD:C52([InventoryStack:29])
			[InventoryStack:29]ExtendedCost:17:=[InventoryStack:29]ExtendedCost:17+vR2
			SAVE RECORD:C53([InventoryStack:29])
			[POReceipt:95]StackValues:10:=Sum:C1([InventoryStack:29]ExtendedCost:17)
			[POReceipt:95]Comment:9:="OK, Forced <$0.20"
			SAVE RECORD:C53([POReceipt:95])
		: (vR3<0.005)
			[POReceipt:95]Comment:9:="OK"
		Else 
			[POReceipt:95]Comment:9:="Review"
			SAVE RECORD:C53([POReceipt:95])
	End case 
	NEXT RECORD:C51([POReceipt:95])
End for 

If (False:C215)
	CONFIRM:C162("Set Stack to specific value")
	If (OK=1)
		READ WRITE:C146([InventoryStack:29])
		LOAD RECORD:C52([InventoryStack:29])
		vR1:=Num:C11(Request:C163("Enter Correct Value"))
		If (OK=1)
			[InventoryStack:29]ExtendedCost:17:=vR1
			If ([InventoryStack:29]QtyOnHand:9#0)
				[InventoryStack:29]UnitCost:11:=Round:C94([InventoryStack:29]ExtendedCost:17/[InventoryStack:29]QtyOnHand:9; 5)
			End if 
			SAVE RECORD:C53([InventoryStack:29])
		End if 
	End if 
End if 


If (False:C215)
	CONFIRM:C162("Set Stack to specific value")
	If (OK=1)
		READ WRITE:C146([InventoryStack:29])
		LOAD RECORD:C52([InventoryStack:29])
		vR1:=Num:C11(Request:C163("Enter Correct Value"))
		If (OK=1)
			[InventoryStack:29]ExtendedCost:17:=vR1
			If ([InventoryStack:29]QtyOnHand:9#0)
				[InventoryStack:29]UnitCost:11:=Round:C94([InventoryStack:29]ExtendedCost:17/[InventoryStack:29]QtyOnHand:9; 5)
			End if 
			SAVE RECORD:C53([InventoryStack:29])
		End if 
	End if 
End if 
//
If (False:C215)
	CONFIRM:C162("Add/Subtract Stack to stack value")
	If (OK=1)
		READ WRITE:C146([InventoryStack:29])
		LOAD RECORD:C52([InventoryStack:29])
		vR1:=Num:C11(Request:C163("Enter Change Value"))
		If (OK=1)
			[InventoryStack:29]ExtendedCost:17:=[InventoryStack:29]ExtendedCost:17+vR1
			If ([InventoryStack:29]QtyOnHand:9#0)
				[InventoryStack:29]UnitCost:11:=Round:C94([InventoryStack:29]ExtendedCost:17/[InventoryStack:29]QtyOnHand:9; 5)
			End if 
			SAVE RECORD:C53([InventoryStack:29])
		End if 
	End if 
End if 
//
If (False:C215)
	CREATE RECORD:C68([InventoryStack:29])
	
	[InventoryStack:29]ItemNum:2:="Miscellaneous"
	[InventoryStack:29]UnitCost:11:=[POReceipt:95]VendorInvoiceAmount:7
	[InventoryStack:29]ReceiptID:16:=[POReceipt:95]idUnique:1
	[InventoryStack:29]QtyOnHand:9:=1
	[InventoryStack:29]ExtendedCost:17:=[POReceipt:95]VendorInvoiceAmount:7
	[InventoryStack:29]VendorID:10:=[POReceipt:95]VendorID:3
	[InventoryStack:29]DateEntered:3:=[POReceipt:95]VendorInvoiceDate:5
	[InventoryStack:29]DocID:5:=[POReceipt:95]poNum:2
	[InventoryStack:29]DateVendorInvc:27:=[POReceipt:95]VendorInvoiceDate:5
	[InventoryStack:29]tableNum:30:=Table:C252(->[POReceipt:95])
	SAVE RECORD:C53([InventoryStack:29])
End if 