//%attributes = {"publishedWeb":true}
jDateTimeUserCl("Enter Date/Time Range")
If (OK=1)
	QUERY:C277([DInventory:36]; [DInventory:36]dtCreated:15>=vlDTStart; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=vlDTEnd)
	ProcessTableOpen(->[DInventory:36])
End if 
