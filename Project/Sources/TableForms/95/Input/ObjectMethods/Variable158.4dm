If ([POReceipt:95]VendorInvoiceFreight:6=0)
	ALERT:C41("Freight value is zero!")
Else 
	CONFIRM:C162("Add a Freight Stack at Value: "+String:C10([POReceipt:95]VendorInvoiceFreight:6))
	If (OK=1)
		CREATE RECORD:C68([InventoryStack:29])
		
		[InventoryStack:29]ItemNum:2:="FreightPO"
		[InventoryStack:29]UnitCost:11:=1
		[InventoryStack:29]ReceiptID:16:=[POReceipt:95]idUnique:1
		[InventoryStack:29]QtyOnHand:9:=1
		[InventoryStack:29]ExtendedCost:17:=[POReceipt:95]VendorInvoiceFreight:6
		[InventoryStack:29]VendorID:10:=[POReceipt:95]VendorID:3
		[InventoryStack:29]DateEntered:3:=[POReceipt:95]VendorInvoiceDate:5
		[InventoryStack:29]DocID:5:=[POReceipt:95]poNum:2
		[InventoryStack:29]DateVendorInvc:27:=[POReceipt:95]VendorInvoiceDate:5
		[InventoryStack:29]tableNum:30:=Table:C252(->[POReceipt:95])
		SAVE RECORD:C53([InventoryStack:29])
		QUERY:C277([InventoryStack:29]; [InventoryStack:29]ReceiptID:16=[POReceipt:95]idUnique:1)
		[POReceipt:95]StackValues:10:=Round:C94(Sum:C1([InventoryStack:29]ExtendedCost:17); 2)
		vR1:=[POReceipt:95]VendorInvoiceAmount:7-[POReceipt:95]StackValues:10
	End if 
End if 