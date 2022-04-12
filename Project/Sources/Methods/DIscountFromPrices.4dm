//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-04-23T00:00:00, 12:50:58
// ----------------------------------------------------
// Method: DIscountFromPrices
// Description
// Modified: 04/23/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_REAL:C285($0; $1; $unitPrice; $2; $discountedPrice)
$unitPrice:=$1
$discountedPrice:=$2
$0:=Round:C94(($unitPrice-$discountedPrice)/$unitPrice*100; 5)