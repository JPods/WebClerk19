If (False:C215)
	//Object Method: bService
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
If (Size of array:C274(aPoRcptSelect)>0)
	QUERY:C277([POReceipt:95]; [POReceipt:95]idNum:1=aPoRcptID{aPoRcptSelect{1}})
	$k:=Size of array:C274(aStkDocID)
	TRACE:C157
	$w:=Find in array:C230(aStkItem; "FreightPO")
	If ($w>0)
		GOTO RECORD:C242([InventoryStack:29]; aStkRec{$w})
		[InventoryStack:29]extendedCost:17:=vrVendorInvoiceFreight
		[InventoryStack:29]unitCost:11:=vrVendorInvoiceFreight
		
		SAVE RECORD:C53([InventoryStack:29])
	Else 
		If (vrVendorInvoiceFreight#0)
			CREATE RECORD:C68([InventoryStack:29])
			
			[InventoryStack:29]itemNum:2:="FreightPO"
			[InventoryStack:29]unitCost:11:=vrVendorInvoiceFreight
			[InventoryStack:29]receiptid:16:=[POReceipt:95]idNum:1
			[InventoryStack:29]qtyOnHand:9:=1
			[InventoryStack:29]unitCost:11:=vrVendorInvoiceFreight
			[InventoryStack:29]extendedCost:17:=vrVendorInvoiceFreight
			[InventoryStack:29]vendorID:10:=[POReceipt:95]vendorID:3
			[InventoryStack:29]dateEntered:3:=[POReceipt:95]vendorInvoiceDate:5
			[InventoryStack:29]docid:5:=[POReceipt:95]idNumPO:2
			[InventoryStack:29]dateVendorInvc:27:=[POReceipt:95]vendorInvoiceDate:5
			[InventoryStack:29]tableNum:30:=Table:C252(->[POReceipt:95])
			SAVE RECORD:C53([InventoryStack:29])
		End if 
	End if 
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=[POReceipt:95]idNumPO:2; *)
	QUERY:C277([InventoryStack:29];  & [InventoryStack:29]itemNum:2="FreightPO")
	[PO:39]shipHandling:21:=Sum:C1([InventoryStack:29]extendedCost:17)
	SAVE RECORD:C53([PO:39])
	//
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=aPoRcptID{aPoRcptSelect{1}})
	
	Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
	//  --  CHOPPED  AL_UpdateArrays(eShipAdj; -2)
	$k:=Size of array:C274(aStkDocID)
	TRACE:C157
	iLoReal7:=0
	iLoReal8:=0
	iLoReal9:=0
	iLoReal6:=0
	iLoReal5:=0
	iLoReal4:=0
	For ($i; 1; $k)
		If (aStkItem{$i}="FreightPO")
			iLoReal8:=iLoReal8+aStkOrCost{$i}
		Else 
			iLoReal7:=iLoReal7+(aStkOrCost{$i}*aStkOrQty{$i})
			iLoReal5:=iLoReal4+aStkDuty{$i}
			iLoReal4:=iLoReal4+aStkNonPd{$i}
			iLoReal6:=iLoReal4+aStkVAT{$i}
		End if 
	End for 
	iLoReal9:=iLoReal8+iLoReal7
	iLoReal10:=vrVendorInvoiceAmount-iLoReal9
End if 





