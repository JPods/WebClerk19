//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/04/20, 21:24:38
// ----------------------------------------------------
// Method: PathsToPOSIX
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable; $ptField)
C_LONGINT:C283($i; $k)
$ptTable:=Table:C252(Table:C252($1))
$ptField:=$1
$k:=Records in selection:C76($ptTable->)
FIRST RECORD:C50($ptTable->)
For ($i; 1; $k)
	$ptField->:=Convert path system to POSIX:C1106($ptField->)
	SAVE RECORD:C53($ptTable->)
	NEXT RECORD:C51($ptTable->)
End for 
UNLOAD RECORD:C212($ptTable->)