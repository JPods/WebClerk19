// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/26/12, 17:06:06
// ----------------------------------------------------
// Method: Object Method: b18
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (iLoInteger1=0)
	iLoInteger1:=1
End if 
QUERY:C277([WorkOrder:66]; [WorkOrder:66]woType:60="Transfer"; *)
QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtComplete:6=0; *)
QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtCreated:44>DateTime_Enter((Current date:C33-iLoInteger1); ?00:00:00?))
ORDER BY:C49([WorkOrder:66]dtCreated:44; <)  //### jwm ### 20130128_1657
WOTransfers_Sort(iLoText2)
//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
