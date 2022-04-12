//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-14T00:00:00, 11:46:49
// ----------------------------------------------------
// Method: ConsolidateFile
// Description
// Modified: 10/14/16
// 
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $2; $tablePt)
//curValue; changeValue; RelateField1.... RelateFieldN
C_LONGINT:C283($i; $k; $tableCnt; $tableInc)
$tableCnt:=Count parameters:C259
For ($tableInc; 3; $tableCnt)  //skip the first 2 variables
	$tablePt:=Table:C252(Table:C252(${$tableInc}))
	QUERY:C277($tablePt->; ${$tableInc}->=$1->)
	$k:=Records in selection:C76($tablePt->)
	FIRST RECORD:C50($tablePt->)
	For ($i; 1; $k)
		${$tableInc}->:=$2->
		SAVE RECORD:C53($tablePt->)
		NEXT RECORD:C51($tablePt->)
	End for 
	REDUCE SELECTION:C351($tablePt->; 0)
	FLUSH CACHE:C297
End for 