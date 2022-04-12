//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-08-12T00:00:00, 11:45:07
// ----------------------------------------------------
// Method: dInventoryFillFromArray
// Description
// Modified: 08/12/16
// 
// 
//
// Parameters
// ----------------------------------------------------



// Modified by: Bill James (2016-08-12T00:00:00)  qqqq????zzzz
//  Test this

C_LONGINT:C283($relatedInc; $cnt; $dtCreate; $1)
If (Count parameters:C259=1)
	$dtCreate:=$1
Else 
	$dtCreate:=DateTime_Enter
End if 
REDUCE SELECTION:C351([DInventory:36]; 0)
READ WRITE:C146([DInventory:36])
$cnt:=Size of array:C274(dDTCreated)
For ($relatedInc; 1; $cnt)
	CREATE RECORD:C68([DInventory:36])
	$viUniqueID:=[DInventory:36]idNum:33
	
	[DInventory:36]itemNum:1:=dItemNumKey{$relatedInc}
	[DInventory:36]qtyOnHand:2:=dQtyOnHand{$relatedInc}
	[DInventory:36]qtyOnSO:3:=dQtyOnSO{$relatedInc}
	[DInventory:36]qtyOnPo:4:=dQtyOnPO{$relatedInc}
	[DInventory:36]qtyOnWO:5:=dQtyOnWO{$relatedInc}
	[DInventory:36]qtyOnAdj:6:=dQtyOnAdj{$relatedInc}
	[DInventory:36]unitCost:7:=dUnitCost{$relatedInc}
	[DInventory:36]projectNum:8:=dJobID{$relatedInc}
	[DInventory:36]docid:9:=dDocID{$relatedInc}
	[DInventory:36]idNumLine:10:=dLineNum{$relatedInc}
	[DInventory:36]receiptid:11:=dReceiptID{$relatedInc}
	[DInventory:36]customerID:12:=dSource{$relatedInc}
	[DInventory:36]reason:13:=dReason{$relatedInc}
	[DInventory:36]typeID:14:=dType{$relatedInc}
	
	[DInventory:36]note:18:=dNote{$relatedInc}
	[DInventory:36]takeAction:19:=dTakeAction{$relatedInc}
	[DInventory:36]siteID:20:=dSite{$relatedInc}
	[DInventory:36]unitPrice:21:=dUnitPrice{$relatedInc}
	[DInventory:36]changedBy:22:=dChangeBy{$relatedInc}
	[DInventory:36]dateCreated:39:=Current date:C33
	[DInventory:36]timeCreated:40:=Current time:C178
	[DInventory:36]dtCreated:15:=$dtCreate
	SAVE RECORD:C53([DInventory:36])
End for 
REDUCE SELECTION:C351([DInventory:36]; 0)
READ ONLY:C145([DInventory:36])
FLUSH CACHE:C297
IVNT_dRayInit