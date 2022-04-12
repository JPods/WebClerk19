//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 16:27:22
// ----------------------------------------------------
// Method: ActionBy_Customers
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
QUERY:C277([QQQCustomer:2]; [QQQCustomer:2]actionBy:139=$vtUserName; *)
QUERY:C277([QQQCustomer:2];  & ; [QQQCustomer:2]actionDate:61>=$vdBegin; *)
QUERY:C277([QQQCustomer:2];  & ; [QQQCustomer:2]actionDate:61<=$vdEnd)