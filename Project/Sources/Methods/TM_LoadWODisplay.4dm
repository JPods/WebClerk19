//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/26/06, 07:56:56
// ----------------------------------------------------
// Method: TM_LoadWODisplay
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_DATE:C307($2; $3)
$dtBegin:=DateTime_DTTo($2; ?00:00:00?)
$dtEnd:=DateTime_DTTo($3; ?23:59:59?)
QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=$1)
$k:=Records in selection:C76([WorkOrder:66])
WO_FillArrays($k)
