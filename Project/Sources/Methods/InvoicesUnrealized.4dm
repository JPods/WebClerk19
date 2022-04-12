//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/20/11, 22:38:12
// ----------------------------------------------------
// Method: InvoicesUnrealized
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($script; $processName)
$processName:="Unrealized Invoices"
$script:="QUERY([Invoice];[Invoice]Consignment#"+Char:C90(34)+Char:C90(34)+")"
DB_ShowCurrentSelection(->[Invoice:26]; $script; 1; $processName)

