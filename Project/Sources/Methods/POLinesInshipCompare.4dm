//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/24/13, 10:02:10
// ----------------------------------------------------
// Method: POLinesInshipCompare
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k)

READ WRITE:C146([QQQPOLine:40])
$k:=Records in selection:C76([QQQPOLine:40])
FIRST RECORD:C50([QQQPOLine:40])
For ($i; 1; $k)
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]DocID:5=[QQQPOLine:40]poNum:1; *)
	QUERY:C277([InventoryStack:29];  & [InventoryStack:29]LineNum:12=[QQQPOLine:40]lineNum:14; *)
	QUERY:C277([InventoryStack:29];  & [InventoryStack:29]tableNum:30=Table:C252(->[QQQPOLine:40]))
	ALERT:C41("[InventoryStack] records: "+String:C10(Records in selection:C76([InventoryStack:29])))
	vR1:=Sum:C1([InventoryStack:29]QtyOnHand:9)
	ALERT:C41("[InventoryStack] records: "+String:C10(Records in selection:C76([InventoryStack:29]))+", Count: "+String:C10(vR1))
End for 
