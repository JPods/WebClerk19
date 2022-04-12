//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 03/29/18, 14:08:42
// ----------------------------------------------------
// Method: String_CapitalizeFirstChar
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtString; $vtFirst)
$vtString:=$1

// COPY FIRST CHARACTER AND SET IT TO UPPERCASE

$vtFirst:=Substring:C12($vtString; 1; 1)
$vtFirst:=Uppercase:C13($vtFirst)

// REMOVE FIRST CHARACTER

$vtString:=Substring:C12($vtString; 2; Length:C16($vtString)-1)

// COMBINE NEW STRING

$vtString:=$vtFirst+$vtString

// RETURN THE VALUE

$0:=$vtString
