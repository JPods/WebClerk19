//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/12/18, 12:41:40
// ----------------------------------------------------
// Method: ConsolidateAccountID
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptField; $ptTable; $2; $ptFieldValue)
$ptField:=$1
$ptTable:=Table:C252(Table:C252($ptField))

C_LONGINT:C283($i; $k)
$k:=Records in selection:C76($ptTable->)
FIRST RECORD:C50($ptTable->)
For ($i; 1; $k)
	$ptField->:=$2->
	SAVE RECORD:C53($ptTable->)
	NEXT RECORD:C51($ptTable->)
End for 
UNLOAD RECORD:C212($ptTable->)