//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 16:23:12
// ----------------------------------------------------
// Method: ActionBy_Proposals
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
QUERY:C277([Proposal:42]; [Proposal:42]actionBy:94=$vtUserName; *)
QUERY:C277([Proposal:42];  & ; [Proposal:42]actionDate:95>=$vdBegin; *)
QUERY:C277([Proposal:42];  & ; [Proposal:42]actionDate:95<=$vdEnd)