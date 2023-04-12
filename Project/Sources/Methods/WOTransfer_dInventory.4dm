//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/22/13, 14:03:13
// ----------------------------------------------------
// Method: WOTransfer_dInventory
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
If ($1="Receive")
	
	CREATE RECORD:C68([DInventory:36])
	[DInventory:36]itemNum:1:=[WorkOrder:66]itemNum:12
	[DInventory:36]qtyOnWO:5:=[WorkOrder:66]qtyOrdered:13
	[DInventory:36]unitCost:7:=[WorkOrder:66]costPlanned:15
	[DInventory:36]idNumDoc:9:=[WorkOrder:66]idNum:29
	[DInventory:36]customerID:12:=[WorkOrder:66]siteIDTo:61
	[DInventory:36]reason:13:="WO Receive"
	[DInventory:36]typeID:14:="WT"
	[DInventory:36]dateCreated:39:=Current date:C33
	[DInventory:36]timeCreated:40:=Current time:C178
	[DInventory:36]dtCreated:15:=DateTime_DTTo
	[DInventory:36]note:18:="From: "+[WorkOrder:66]siteIDFrom:62+"\r"+"To: "+[WorkOrder:66]siteIDTo:61+"\r"
	[DInventory:36]siteID:20:=[WorkOrder:66]siteIDTo:61
	[DInventory:36]changedBy:22:=Current user:C182
	[DInventory:36]tableName:30:=Table name:C256(->[DInventory:36])
	
	
	
	//[dInventory]QtyOnHand:=0
	//[dInventory]QtyOnSO
	//[dInventory]QtyOnPO
	//[dInventory]QtyOnAdj:=0
	//[dInventory]projectNum
	//[dInventory]LineNum:=0
	//[dInventory]ReceiptID:=0
	//[dInventory]TakeAction:=""
	//[dInventory]UnitPrice:=0
	//[dInventory]Division:=
	SAVE RECORD:C53([DInventory:36])
	UNLOAD RECORD:C212([DInventory:36])
Else   //ship
	
	CREATE RECORD:C68([DInventory:36])
	[DInventory:36]itemNum:1:=[WorkOrder:66]itemNum:12
	[DInventory:36]qtyOnWO:5:=-[WorkOrder:66]qtyOrdered:13
	[DInventory:36]unitCost:7:=[WorkOrder:66]costPlanned:15
	[DInventory:36]idNumDoc:9:=[WorkOrder:66]idNum:29
	[DInventory:36]customerID:12:=[WorkOrder:66]siteIDFrom:62
	[DInventory:36]reason:13:="WO Ship"
	[DInventory:36]typeID:14:="WT"
	[DInventory:36]dateCreated:39:=Current date:C33
	[DInventory:36]timeCreated:40:=Current time:C178
	[DInventory:36]dtCreated:15:=DateTime_DTTo
	[DInventory:36]note:18:="From: "+[WorkOrder:66]siteIDFrom:62+"\r"+"To: "+[WorkOrder:66]siteIDTo:61
	[DInventory:36]siteID:20:=[WorkOrder:66]siteIDFrom:62
	[DInventory:36]changedBy:22:=Current user:C182
	[DInventory:36]tableName:30:=Table name:C256(->[DInventory:36])
	
	
	
	//[dInventory]QtyOnHand:=0
	//[dInventory]QtyOnSO
	//[dInventory]QtyOnPO
	//[dInventory]QtyOnAdj:=0
	//[dInventory]projectNum
	//[dInventory]LineNum:=0
	//[dInventory]ReceiptID:=0
	//[dInventory]TakeAction:=""
	//[dInventory]UnitPrice:=0
	//[dInventory]Division:=
	
	SAVE RECORD:C53([DInventory:36])
	UNLOAD RECORD:C212([DInventory:36])
	
	
End if 

TallyInventory  // ### jwm ### 20180928_1134