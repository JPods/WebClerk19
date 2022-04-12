//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 16:24:45
// ----------------------------------------------------
// Method: ActionBy_Invoices
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
QUERY:C277([Invoice:26]; [Invoice:26]actionBy:110=$vtUserName; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]actionDate:111>=$vdBegin; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]actionDate:111<=$vdEnd)