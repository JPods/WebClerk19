//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 05/07/19, 16:43:43
// ----------------------------------------------------
// Method: PageGetIcon
// Description
// 
//
// Parameters
// ----------------------------------------------------

// INITIALIZE VARIABLES

C_TEXT:C284($0)

C_TEXT:C284($1; $vtIconName)
$vtIconName:=$1

C_TEXT:C284(<>vtWCIconPath)

// RETURN THE ICON

$0:=PageGetObject(<>vtWCIconPath+$vtIconName)