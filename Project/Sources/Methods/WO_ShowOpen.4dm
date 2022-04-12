//%attributes = {"publishedWeb":true}
//Method: WO_ShowOpen
If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 635; 475; 8)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 
QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtComplete:6=0)
ProcessTableOpen(->[WorkOrder:66])