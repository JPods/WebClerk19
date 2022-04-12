QUERY:C277([Item:4]; [Item:4]itemNum:1=[InventoryStack:29]ItemNum:2)
If (Records in selection:C76([Item:4])#1)
	ALERT:C41("You must enter a valid Item Number.")
	HIGHLIGHT TEXT:C210([InventoryStack:29]ItemNum:2; 1; 20)
Else 
	UNLOAD RECORD:C212([Item:4])
End if 
jAlertMessage(9292)