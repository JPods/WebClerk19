//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-22T00:00:00, 19:46:47
// ----------------------------------------------------
// Method: LastRecordInTable
// Description
// Modified: 08/22/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $tableNum)
$tableNum:=$1
C_POINTER:C301($ptTable)
$ptTable:=Table:C252($tableNum)
ALL RECORDS:C47($ptTable->)
LAST RECORD:C200($ptTable->)
<>aLastRecNum{$tableNum}:=Record number:C243($ptTable->)
REDUCE SELECTION:C351($ptTable->; 0)