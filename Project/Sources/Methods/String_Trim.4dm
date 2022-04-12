//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/06/19, 09:00:12
// ----------------------------------------------------
// Method: String_Trim
// Description
// 
//
// Parameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// $0;$1
C_BOOLEAN:C305($vbOK)
C_TEXT:C284($0; $1; $vtInput; $vtInputTrimmed)

//==================================
//  Initialize variables 
//==================================

$vbOK:=False:C215
$vtInput:=""
$vtInputTrimmed:=""

//</declarations>


$vtInput:=$1

// USE PHP'S BUILT IN TRIM FUNCTION

$vbOK:=PHP Execute:C1058(""; "trim"; $vtInputTrimmed; $vtInput)

// RETURN TRIMMED STRING

$0:=$vtInputTrimmed
