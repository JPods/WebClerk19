//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/04/21, 01:04:42
// ----------------------------------------------------
// Method: STR_GetTableNameArray
// Description
// 
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $ds : Object
var $c : Collection
var $o : Object
ARRAY TEXT:C222($aTableNames; 0)
ARRAY LONGINT:C221($aTableNums; 0)
$ds:=ds:C1482

//For each ($o; $ds)
//APPEND TO ARRAY($aTableNames; $o.getDataClass.tableName)
//APPEND TO ARRAY($aTableNums; $o.getDataClass.tableNumber)
//End for each 
//$c:=ds.toCollection
// switch to ds process
OB GET PROPERTY NAMES:C1232(ds:C1482; $aTableNames)
var $inc; $cnt : Integer
SORT ARRAY:C229($aTableNames)
$cnt:=Size of array:C274($aTableNames)
ARRAY LONGINT:C221($aTableNums; $cnt)
For ($inc; $cnt; 1; -1)
	If ($aTableNames{$cnt}="zz@")
		DELETE FROM ARRAY:C228($aTableNames; $inc; 1)
		DELETE FROM ARRAY:C228($aTableNums; $inc; 1)
	Else 
		$aTableNums{$inc}:=ds:C1482[$aTableNames{$inc}].getInfo().tableNumber
	End if 
End for 
COPY ARRAY:C226($aTableNames; $1->)
If (Count parameters:C259=2)
	COPY ARRAY:C226($aTableNums; $2->)
End if 