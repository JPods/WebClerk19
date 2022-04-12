//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 16:22:01
// ----------------------------------------------------
// Method: ActionBy_WorkOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0; $1; $vtUserName)
$vtUserName:=$1
C_DATE:C307($2; $vdBegin; $3; $vdEnd)
$vdBegin:=$2
$vdEnd:=$3
QUERY:C277([WorkOrder:66]; [WorkOrder:66]ActionBy:8=$vtUserName; *)
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]ActionDate:105>=$vdBegin; *)
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]ActionDate:105<=$vdEnd)