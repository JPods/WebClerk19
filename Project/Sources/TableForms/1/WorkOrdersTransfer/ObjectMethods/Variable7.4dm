If (vltaskID>0)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=vltaskID)
	
End if 
WOTransfers_Sort(iLoText2)
//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)

