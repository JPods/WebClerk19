//%attributes = {"publishedWeb":true}
//Procedure: Sch_FillNameID
//July 29, 1996
C_POINTER:C301($1)
C_DATE:C307($2; $endDate; $3; $beginDate)
If (Count parameters:C259>1)
	$beginDate:=$2
	$endDate:=$2
	If (Count parameters:C259>2)
		$endDate:=$3
	End if 
End if 
//QUERY([WorkOrder];[WorkOrder]DTCompleted=0;*)
QUERY:C277([WorkOrder:66]; [WorkOrder:66]actionBy:8=$1->; *)
If ($2#!00-00-00!)
	vlDTStart:=DateTime_Enter($beginDate; ?00:00:00?)
	vlDTEnd:=DateTime_Enter($endDate; ?23:59:59?)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5>=vlDTStart; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=vlDTEnd; *)
End if 
QUERY:C277([WorkOrder:66])