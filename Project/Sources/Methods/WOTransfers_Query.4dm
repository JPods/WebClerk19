//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/02/14, 12:42:33
// ----------------------------------------------------
// Method: WOTranfers_Query
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
	Else   //: (iLoText2="View")
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woType:60="Transfer"; *)
			//QUERY([WorkOrder];&[WorkOrder]DTCompleted=0;*)
		End if 
End case 
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44>=DateTime_Enter((iLoDate1-iLoInteger1); ?00:00:00?); *)
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44<=DateTime_Enter((iLoDate1+iLoInteger1); ?23:59:59?); *)
QUERY:C277([WorkOrder:66])

//WOTransfers_Sort (iLoText2)
////  CHOPPED  AL_UpdateFields (eWorkOrders;2)

