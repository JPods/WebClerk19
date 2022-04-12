//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-08T00:00:00, 10:38:38
// ----------------------------------------------------
// Method: CloneChildrenRecords
// Description
// Modified: 09/08/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)  // example
	CloneChildrenRecords(->[SpecialDiscount:44]idUnique:4; ->[ItemDiscount:45]SpecialDiscountsID:1)
End if 
// qqqq test this
C_POINTER:C301($1; $ptPrimeTableField; $2; $ptChildTableField; $ptPrimeTable; $ptChildTable)
$ptPrimeTableField:=$1
$ptChildTableField:=$2
$ptPrimeTable:=Table:C252(Table:C252($ptPrimeTableField))
$ptChildTable:=Table:C252(Table:C252($ptChildTableField))
QUERY:C277($ptChildTable->; $ptChildTableField->=$ptPrimeTableField->)
ARRAY LONGINT:C221($aChildren; 0)
SELECTION TO ARRAY:C260($ptChildTable->; $aChildren)
DUPLICATE RECORD:C225($ptPrimeTable->)  // autoincrement prime table
SAVE RECORD:C53($ptPrimeTable->)
C_LONGINT:C283($i; $k)
$k:=Size of array:C274($aChildren)
For ($i; 1; $k)
	GOTO RECORD:C242($ptChildTable->; $aChildren{$i})  // ### jwm ### 20161024_1353
	DUPLICATE RECORD:C225($ptChildTable->)
	$ptChildTableField->:=$ptPrimeTableField->
	SAVE RECORD:C53($ptChildTable->)
End for 
UNLOAD RECORD:C212($ptChildTable->)
//  