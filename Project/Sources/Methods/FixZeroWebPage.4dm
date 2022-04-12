//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-11-03T00:00:00, 02:01:33
// ----------------------------------------------------
// Method: FixZeroWebPage
// Description
// Modified: 11/03/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable; $ptField)
$ptField:=$1
$ptTable:=Table:C252(Table:C252($1))
C_LONGINT:C283($recInc; $recCnt)
QUERY:C277($ptTable->; $ptField->="0")
$recCnt:=Records in selection:C76($ptTable->)
FIRST RECORD:C50($ptTable->)
For ($recInc; 1; $recCnt)
	For ($i; 1; $k)
		$ptField->:=""
	End for 
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 
