//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/26/18, 13:25:00
// ----------------------------------------------------
// Method: ArrayDistinct
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptField; $ptTable)
C_TEXT:C284($tableName)
C_LONGINT:C283($tableNum; $fieldNum; $theType)
$fieldNum:=0
ARRAY LONGINT:C221(aLDistinct; 0)
ARRAY TEXT:C222(atDistinct; 0)

Case of 
	: (Count parameters:C259=1)
		$ptField:=$1
		$fieldNum:=Field:C253($ptField)
		$tableNum:=Table:C252($ptField)
		$ptTable:=Table:C252($tableNum)
	: (PTCURTABLE=(->[QQQCounter:41]))
		$tableNum:=[QQQCounter:41]TableNum:4
		$ptTable:=Table:C252($tableNum)
		$fieldNum:=STR_GetUniqueFieldNum(Table name:C256([QQQCounter:41]TableNum:4))
		$ptField:=Field:C253([QQQCounter:41]TableNum:4; $fieldNum)
	Else 
		ConsoleMessage("(P) ArrayDistinct:  Pass a pointer to a field or be in a [Counter] record.")
End case 


If ($fieldNum>0)
	$theType:=Type:C295($ptField->)
	READ ONLY:C145($ptTable->)
	ALL RECORDS:C47($ptTable->)
	Case of 
		: ($theType=Is longint:K8:6)
			DISTINCT VALUES:C339($ptField->; aLDistinct)
			SORT ARRAY:C229(aLDistinct)
		: ($theType=Is text:K8:3)
			DISTINCT VALUES:C339($ptField->; atDistinct)
			SORT ARRAY:C229(atDistinct)
	End case 
End if 
REDUCE SELECTION:C351($ptTable->; 0)
READ WRITE:C146($ptTable->)