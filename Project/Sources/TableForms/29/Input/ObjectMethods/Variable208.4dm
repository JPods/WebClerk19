READ WRITE:C146([InventoryStack:29])
LOAD RECORD:C52([InventoryStack:29])
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