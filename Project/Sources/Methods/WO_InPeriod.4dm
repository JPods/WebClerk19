//%attributes = {"publishedWeb":true}
//Method: WO_InPeriod
If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 635; 475; 8)
	Process_InitLocal
	ptCurTable:=(->[Base:1])
End if 
jBetweenDates("WO's in Period.")
If (OK=1)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtCreated:44>=DateTime_DTTo(vdDateBeg; ?00:00:00?); *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtCreated:44<=DateTime_DTTo(vdDateEnd; ?23:59:59?))
	ProcessTableOpen(->[WorkOrder:66])
End if 