//%attributes = {}

// Modified by: Bill James (2021-12-25T06:00:00Z)
// Method: Form_Return
// Description 
// Parameters
// ----------------------------------------------------
var $lbName_t; $tableName; $columnAdder_t : Text
var $form; $0; $1; $listboxSetup_o; $columnSetup_o : Object
var $viCnt; $viInc : Integer
var $oneField_o; $fields_o : Object


// setup the ListBox
$listboxSetup_o:=$1
$columnSetup_o:=$listboxSetup_o.columns
// setup below

$lbName_t:=$listboxSetup_o.listboxName
$tableName:=$listboxSetup_o.tableName
$obDateStore:=ds:C1482[$tableName]


var $sel_ent; $form : Object




TextToArray($fieldList_t; ->$aColumns)
var $fieldName : Text
var $width; $height : Integer


For each ($fieldName; $cBuild)
	$obj:=New object:C1471("type"; "listbox"; "listboxType"; "collection"; \
		"dataSource"; $colName; "left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
	
End for each 





var $page; $form : Object
$page:=New object:C1471("objects"; New object:C1471("myListBox"; $obj))
$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))



$form:=LBX_DemoDynamic(4; ->eSel; ->$aColumns)  // Entity Collection #1


