//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/25/07, 17:46:39
// ----------------------------------------------------
// Method: UniqueIDPassAlong
// Description
// Pass Records to another type of transaction, Example, Orders to invoice service records
//
// Parameters
//$1 pointer to table
//$2 pointer to key input field
//$3 pointer to value to assign
// ----------------------------------------------------
C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($incRecs; $cntRecs)
$cntRecs:=Records in selection:C76($1->)
If ($cntRecs>0)
	FIRST RECORD:C50($1->)
	For ($incRecs; 1; $cntRecs)
		$2->:=$3->
		SAVE RECORD:C53($1->)
		NEXT RECORD:C51($1->)
	End for 
End if 