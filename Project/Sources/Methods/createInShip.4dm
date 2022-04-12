//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/21/07, 16:05:41
// ----------------------------------------------------
// Method: createInShip
// Description
// 
//
// Parameters
// ----------------------------------------------------


//C_POINTER($1;$3;$6)
//C_LONGINT($4;$5;$8;$9)
//C_REAL([dInventory]QtyOnHand;$7;$11;$12;$13)
//C_TEXT($10)
If ([DInventory:36]itemNum:1#"")
	READ WRITE:C146([InventoryStack:29])
	CREATE RECORD:C68([InventoryStack:29])
	
	[InventoryStack:29]itemNum:2:=[DInventory:36]itemNum:1
	[InventoryStack:29]qtyOnHand:9:=[DInventory:36]qtyOnHand:2
	If ([DInventory:36]qtyOnHand:2>0)
		[InventoryStack:29]qtyAvailable:14:=[DInventory:36]qtyOnHand:2
	Else 
		[InventoryStack:29]qtyAvailable:14:=0
	End if 
	[InventoryStack:29]changeReason:6:=[DInventory:36]reason:13
	[InventoryStack:29]projectNum:4:=[DInventory:36]projectNum:8
	[InventoryStack:29]docid:5:=[DInventory:36]docid:9
	If ([DInventory:36]typeid:14#"PO")
		[InventoryStack:29]jrnlComplete:13:=True:C214
	Else 
		[InventoryStack:29]jrnlComplete:13:=False:C215
		//QUERY([PO];[PO]PONum=$5)
		//If ([PO]DateVendorInvc=!00/00/00!)
		//[InvStack]DateVendorInvc:=Current date
		//Else 
		//[InvStack]DateVendorInvc:=[PO]DateVendorInvc
		//End if 
	End if 
	//TRACE
	[InventoryStack:29]vendorID:10:=[DInventory:36]custVendid:12
	[InventoryStack:29]unitCost:11:=[DInventory:36]unitCost:7
	[InventoryStack:29]lineNum:12:=[DInventory:36]idNumLine:10
	[InventoryStack:29]comment:7:=""
	[InventoryStack:29]createdBy:8:=[DInventory:36]changedBy:22
	[InventoryStack:29]dateEntered:3:=Current date:C33
	[InventoryStack:29]receiptid:16:=[DInventory:36]receiptid:11
	[InventoryStack:29]nonProcCosts:22:=[DInventory:36]nonProdCost:25
	[InventoryStack:29]duties:21:=[DInventory:36]duties:26
	[InventoryStack:29]vaTax:23:=[DInventory:36]vaTax:27
	[InventoryStack:29]extendedCost:17:=Round:C94([InventoryStack:29]unitCost:11*[InventoryStack:29]qtyOnHand:9; <>tcDecimalTt)
	[InventoryStack:29]dtDInventoryRecord:31:=[DInventory:36]dtCreated:15
	[InventoryStack:29]tableNum:30:=Table:C252(->[POReceipt:95])
	SAVE RECORD:C53([InventoryStack:29])
	READ ONLY:C145([InventoryStack:29])
End if 

