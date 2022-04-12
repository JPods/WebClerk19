//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/20/18, 11:48:10
// ----------------------------------------------------
// Method: SQL_Trim
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtText)
$vtText:=$1
Begin SQL
	SELECT TRIM(BOTH FROM :$vtText) from Control limit 1 INTO :$vtText;
End SQL
$0:=$vtText
