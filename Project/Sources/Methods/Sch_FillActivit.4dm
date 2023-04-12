//%attributes = {"publishedWeb":true}
//Procedure: Sch_FillActivit
C_POINTER:C301($1)
C_DATE:C307($2; $3; $endDate)
$endDate:=$2
If (Count parameters:C259=3)
	$endDate:=$3
End if 
QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtComplete:6=0; *)
QUERY:C277([WorkOrder:66];  & [WorkOrder:66]activity:7=$1->; *)
If ($2#!00-00-00!)
	vlDTStart:=DateTime_DTTo($2; ?00:00:00?)
	vlDTEnd:=DateTime_DTTo($endDate; ?23:59:59?)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5>=vlDTStart; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=vlDTEnd; *)
End if 
QUERY:C277([WorkOrder:66])