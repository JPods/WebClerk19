//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/20/11, 22:24:47
// ----------------------------------------------------
// Method: PaymentsUnrealized
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($script; $processName)
$processName:="Unrealized Payments"
$script:="QUERY([Payment];[Payment]Status="+Txt_Quoted("hold@")+")"
DB_ShowCurrentSelection(->[Payment:28]; $script; 0; $processName)