//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fileNum; vHere)
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
$fileNum:=0
Case of 
	: (vHere=0)
		DB_ShowByTableName("Item")
		$doJoin:=False:C215
	: (vHere=1)
		Case of 
			: (ptCurTable=(->[Usage:5]))
				RELATE ONE SELECTION:C349([Usage:5]; [Item:4])
			: (ptCurTable=(->[ItemSpec:31]))
				RELATE ONE SELECTION:C349([ItemSpec:31]; [Item:4])
			: (ptCurTable=(->[BOM:21]))
				RELATE ONE SELECTION:C349([BOM:21]; [Item:4])
			: (ptCurTable=(->[ItemXRef:22]))
				RELATE ONE SELECTION:C349([ItemXRef:22]; [Item:4])
			: (ptCurTable=(->[InventoryStack:29]))
				RELATE ONE SELECTION:C349([InventoryStack:29]; [Item:4])
			: (ptCurTable=(->[DInventory:36]))
				RELATE ONE SELECTION:C349([DInventory:36]; [Item:4])
			: (ptCurTable=(->[ItemSerial:47]))
				RELATE ONE SELECTION:C349([ItemSerial:47]; [Item:4])
			: (ptCurTable=(->[ItemSerialAction:64]))
				RELATE ONE SELECTION:C349([ItemSerialAction:64]; [Item:4])
			: (ptCurTable=(->[WorkOrder:66]))
				RELATE ONE SELECTION:C349([WorkOrder:66]; [Item:4])
			: (ptCurTable=(->[WOdraw:68]))
				RELATE ONE SELECTION:C349([WOdraw:68]; [Item:4])
			Else 
				DB_ShowByTableName("Item")
				$doJoin:=False:C215
		End case 
		$fileNum:=Table:C252(->[Item:4])*Num:C11(Records in selection:C76([Item:4])>0)
		If (($fileNum>0) & ($doJoin))
			ProcessTableOpen(->[Item:4])
		End if 
	Else 
		jAlertMessage(10100)
End case 