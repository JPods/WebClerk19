//iLo WorkOrders_9
//Script: PartKey
QUERY:C277([Item:4]; [Item:4]description:7=[WorkOrder:66]ItemDescript:34+"@")
If (Records in selection:C76([Item:4])=1)
	pPartNum:=[Item:4]itemNum:1
	WOLnFillItem(pPartNum; -5)
	If (([WorkOrder:66]Description:3="") | (OptKey=1))
		Item_GetSpec
		C_LONGINT:C283($p)
		[WorkOrder:66]Description:3:=[ItemSpec:31]Specification:2
		$p:=Position:C15("<&"; [WorkOrder:66]Description:3)
		If ($p>0)
			[WorkOrder:66]Description:3:=Txt_jitConvert([WorkOrder:66]Description:3)
		End if 
	End if 
	UNLOAD RECORD:C212([ItemSpec:31])
	UNLOAD RECORD:C212([Item:4])
Else 
	BEEP:C151
	BEEP:C151
End if 