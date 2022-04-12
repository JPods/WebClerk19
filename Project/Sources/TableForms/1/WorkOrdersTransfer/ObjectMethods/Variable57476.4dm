// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/05/09, 11:39:12
// ----------------------------------------------------
// Method: Object Method: b61
// Description
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (iLoText2="Request")
		
		
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]action:33="RequestedTransfer"; *)
		End if 
		QUERY:C277([WorkOrder:66])
		
	: (iLoText2="Ship")
		
		
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woType:60="Transfer"; *)
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]action:33="PendingTransfer"; *)
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtComplete:6=0; *)
		End if 
		
	: (iLoText2="Receive")
		
		
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]action:33="CompletedTransfer"; *)
			QUERY:C277([WorkOrder:66];  | [WorkOrder:66]action:33="PendingTransfer"; *)
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]woType:60="Transfer"; *)
			
		End if 
		
		
	Else   //: (iLoText2:="View")
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woType:60="Transfer"; *)
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtComplete:6=0; *)
		End if 
		
End case 
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44>=DateTime_Enter(iLoDate1-iLoInteger1; ?00:00:00?); *)
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44<=DateTime_Enter(iLoDate1+iLoInteger1; ?23:59:59?); *)
QUERY:C277([WorkOrder:66])


WOTransfers_Sort(iLoText2)
//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)

