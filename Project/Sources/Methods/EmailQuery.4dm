//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-10-08T00:00:00, 22:57:23
// ----------------------------------------------------
// Method: EmailQuery
// Description
// Modified: 10/08/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable; $3)
C_TEXT:C284($2)
C_LONGINT:C283($0)
$ptTable:=Table:C252(Table:C252($1))
QUERY:C277($ptTable->; $1->=$2)
$0:=Records in selection:C76($ptTable->)
If (Count parameters:C259>2)
	$3->:=$3->+(": "*Num:C11($3->#""))+String:C10($0)+" "+Table name:C256($ptTable)
End if 