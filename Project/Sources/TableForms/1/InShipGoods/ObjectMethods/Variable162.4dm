TRACE:C157
C_LONGINT:C283(vlReceiptID)
C_BOOLEAN:C305(haveReceiptID; vbSpreadFreight)
If (b31=1)
	vlReceiptID:=-1
End if 
If ((vMod) | (vrVendorInvoiceFreight=vrVendorInvoiceAmount))
	If (vlReceiptID<10)
		haveReceiptID:=True:C214
		booAccept:=True:C214
		TRACE:C157
		vlReceiptID:=PORcpt_CreateNew([PO:39]poNum:5; [PO:39]vendorID:1; True:C214)
		vbSpreadFreight:=False:C215
	End if 
	If (vbSpreadFreight)
		
	Else 
		If (vrVendorInvoiceFreight#0)
			CREATE RECORD:C68([InventoryStack:29])
			
			[InventoryStack:29]itemNum:2:="FreightPO"
			[InventoryStack:29]unitCost:11:=1
			[InventoryStack:29]receiptid:16:=[POReceipt:95]idNum:1
			[InventoryStack:29]qtyOnHand:9:=1
			[InventoryStack:29]extendedCost:17:=[POReceipt:95]vendorInvoiceFreight:6
			[InventoryStack:29]vendorID:10:=[POReceipt:95]vendorID:3
			[InventoryStack:29]dateEntered:3:=[POReceipt:95]vendorInvoiceDate:5
			[InventoryStack:29]docid:5:=[POReceipt:95]poNum:2
			[InventoryStack:29]dateVendorInvc:27:=[POReceipt:95]vendorInvoiceDate:5
			[InventoryStack:29]tableNum:30:=Table:C252(->[POReceipt:95])
			SAVE RECORD:C53([InventoryStack:29])
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=[POReceipt:95]poNum:2; *)
			QUERY:C277([InventoryStack:29];  & [InventoryStack:29]itemNum:2="FreightPO")
			[PO:39]shipHandling:21:=Sum:C1([InventoryStack:29]extendedCost:17)
		End if 
	End if 
	ConsoleMessage("TEST: AcceptPO")
	haveReceiptID:=(vlReceiptID>0)
	acceptPO
	haveReceiptID:=False:C215
	vMod:=False:C215
	vLineMod:=False:C215
Else 
	ALERT:C41("Totals must match or freight only must equal total.")
End if 



//If (vMod)
//If ((vlReceiptID#0)|(haveReceiptID))
//haveReceiptID:=True
//booAccept:=True
//TRACE
//vlReceiptID:=PORcpt_CreateNew ([PO]PONum;[PO]VendorID;True)
//vbSpreadFreight:=False
//End if 
//If (vbSpreadFreight)
//
//Else 
//CREATE RECORD([InvStack])
//
//[InvStack]ItemNum:="FreightPO"
//[InvStack]UnitCost:=1
//[InvStack]ReceiptID:=[POReceipt]ReceiptID
//[InvStack]QtyOnHand:=1
//[InvStack]ExtendedCost:=[POReceipt]VendorInvoiceFreight
//[InvStack]VendorID:=[POReceipt]VendorID
//[InvStack]DateEntered:=[POReceipt]VendorInvoiceDate
//[InvStack]DocID:=[POReceipt]PONum
//[InvStack]DateVendorInvc:=[POReceipt]VendorInvoiceDate
//SAVE RECORD([InvStack])
//End if 
//C_BOOLEAN(haveReceiptID)
//haveReceiptID:=(vlReceiptID>0)
//acceptPO 
//
//haveReceiptID:=False
//vMod:=False
//End if 

