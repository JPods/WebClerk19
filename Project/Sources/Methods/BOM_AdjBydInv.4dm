//%attributes = {"publishedWeb":true}
REDUCE SELECTION:C351([DInventory:36]; 0)
jDateTimeUserCl
If (OK=1)
	QUERY:C277([DInventory:36]; [DInventory:36]dtCreated:15>=vlDTStart; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=vlDTEnd)
	If (Records in selection:C76([DInventory:36])>0)
		ALERT:C41("Assure the first record is the base type.")
	End if 
End if 
ProcessTableOpen(->[DInventory:36])