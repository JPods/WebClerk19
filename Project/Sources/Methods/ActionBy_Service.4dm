//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 16:20:27
// ----------------------------------------------------
// Method: ActionBy_Service
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
QUERY:C277([Service:6]; [Service:6]actionBy:12=$vtUserName; *)
QUERY:C277([Service:6];  & ; [Service:6]dtAction:35>=DateTime_DTTo($vdBegin; ?00:00:00?); *)
QUERY:C277([Service:6];  & ; [Service:6]dtAction:35<=DateTime_DTTo($vdEnd; ?23:59:59?))