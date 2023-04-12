//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/31/21, 16:56:48
// ----------------------------------------------------
// Method: LBX_ColumnBuild
// REF: LBX_ColumnHarvest
// 
// Parameters
// ----------------------------------------------------
var $lbName_t; $tableName; $columnAdder_t : Text
var $1; $listboxSetup_o; $columnSetup_o : Object
var $viCnt; $viInc : Integer
var $oneField_o; $fields_o : Object

// setup the ListBox
$listboxSetup_o:=$1
$columnSetup_o:=$listboxSetup_o.columns
// setup below

$lbName_t:=$listboxSetup_o.listboxName
$tableName:=$listboxSetup_o.tableName

If ($listboxSetup_o.events=Null:C1517)
	$listboxSetup_o.events:=Split string:C1554("onLoad,onClick,onDataChange,onSelectionChange"; ";")
	
End if 


$viCnt:=LISTBOX Get number of columns:C831(*; $lbName_t)
If ($viCnt>0)
	LISTBOX DELETE COLUMN:C830(*; $lbName_t; 1; $viCnt)
End if 

$obDateStore:=ds:C1482[$tableName]
For each ($vtProperty; $columnSetup_o)
	$column_o:=LBX_ColumnFromName($tableName; $vtProperty)
End for each 
