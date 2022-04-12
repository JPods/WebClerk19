//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/21/09, 11:37:08
// ----------------------------------------------------
// Method: Method: Relate_ReturnSet
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $2; $3; $4)  //pt to prime table, prime key field; pt to relate table; related key field
C_LONGINT:C283($incRec; $cntRec)
$cntRec:=Records in selection:C76($1->)
FIRST RECORD:C50($1->)
CREATE EMPTY SET:C140($1->; "Current")
For ($incRec; 1; $cntRec)
	QUERY:C277($3->; $4->=$2->)
	
	
End for 
