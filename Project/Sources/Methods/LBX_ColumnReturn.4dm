//%attributes = {}

// Modified by: Bill James (2021-12-25T06:00:00Z)
// Method: LBX_ColumnReturn
// Description 
// Parameters
// ----------------------------------------------------

// Method: LBX_ColumnBuild
// REF: LBX_ColumnHarvest
// 
// Parameters
// ----------------------------------------------------
var $lbName_t; $tableName; $columnAdder_t; $stringType_t; $align_t; $dateSource : Text
var $form; $0; $1; $listboxSetup_o; $columnSetup_o : Object
var $viCnt; $viInc; $fieldType_i : Integer
var $oneField_o; $fields_o : Object
var $tableNum; $fieldNum : Integer

var $cBuild; $cFilter : Collection
var $obField : Object
$cBuild:=New collection:C1472
If (LB_Fields.sel=Null:C1517)
	$cBuild:=Split string:C1554("company,address1,actionDate"; ";")
Else 
	For each ($obField; LB_Fields.sel)
		$cBuild.push($obField.fieldName)
	End for each 
End if 
$fieldList_t:=$cBuild.join(";")
$viCnt:=$cBuild.length


// setup the ListBox
$listboxSetup_o:=$1
// setup below

$lbName_t:=$listboxSetup_o.listboxName
$tableName:=$listboxSetup_o.tableName

// define standard events
// look at options for this
If ($listboxSetup_o.events=Null:C1517)
	$listboxSetup_o.events:=Split string:C1554("onLoad,onClick,onDataChange,onSelectionChange"; ";")
End if 
var $colObj : Object
$obDateStore:=ds:C1482[$tableName]

// OBJECT GET COORDINATES((OBJECT Get pointer(Object named; $listboxSetup_o.subform))->; $left; $top; $right; $bottom)

OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; "Subform"))->; $left; $top; $right; $bottom)
$width:=$right-$left
$height:=$bottom-$top
// "dataSource"; "Form."+$lbName_t+".ents"; 
var dataTest : Object
dataTest:=ds:C1482[$tableName].all()

//var $obj : Object
//$obj:=New object("type"; "listbox"; \
"listboxType"; "collection"; \
"method"; $lbName_t+".4dm"; \
"metaSource"; $lbName_t; \
"dataSource"; dataTest; \
"currentItemSource"; "Form."+$lbName_t+".cur"; \
"currentItemPositionSource"; "Form."+$lbName_t+".pos"; \
"selectedItemsSource"; "Form."+$lbName_t+".sel"; \
"left"; 0; "top"; 0; \
"width"; $width+15; "height"; $height; \
"events"; New collection; \
"columns"; New collection)

eSel:=ds:C1482.Customer.all()
$dateSource:="eSel"
$colName:=$dateSource
$dataPtr:=(->eSel)
$colName:="eSel"

$tableNum:=STR_GetTableNumber($tableName)
$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
RESOLVE POINTER:C394($dataPtr; $colName; $tableNum; $fieldNum)

var $obj : Object
$obj:=New object:C1471("type"; "listbox"; \
"listboxType"; "collection"; \
"method"; $lbName_t+".4dm"; \
"metaSource"; $lbName_t; \
"dataSource"; $dateSource; \
"currentItemSource"; "Form."+$lbName_t+".cur"; \
"currentItemPositionSource"; "Form."+$lbName_t+".pos"; \
"selectedItemsSource"; "Form."+$lbName_t+".sel"; \
"left"; 0; "top"; 0; \
"width"; $width+15; "height"; $height; \
"events"; New collection:C1472; \
"columns"; New collection:C1472)

$obj:=New object:C1471("type"; "listbox"; \
"listboxType"; "collection"; \
"method"; $lbName_t+".4dm"; \
"metaSource"; $lbName_t; \
"dataSource"; $dateSource; \
"left"; 0; "top"; 0; \
"width"; $width+15; "height"; $height; \
"columns"; New collection:C1472)

For each ($fieldName_t; $cBuild)
	$colObj:=New object:C1471
	
	$vtColumnName:="This."+$fieldName_t
	//$vtColumnName:="Column_"+$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$vtHeader:="Header_"+$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$vtFooter:="Footer_"+$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$ptHeaderVar:=$NilPtr  // Get pointer($vtHeader)
	$vtColumnFormula:="This."+$fieldName_t
	
	$width:=120
	$align:=Align left:K42:2
	$align_t:="left"
	$format:=""
	$fieldType_i:=$obDateStore[$fieldName_t].fieldType
	$stringType_t:=$obDateStore[$fieldName_t].type
	Case of 
		: ($obDateStore[$fieldName_t].type="date")
			$width:=70
			$align:=Align center:K42:3
			$format:=Char:C90(System date short:K1:1)
			$align_t:="center"
		: ($obDateStore[$fieldName_t].type="bool")
			$width:=40
			$align:=Align center:K42:3
			$align_t:="center"
		: ($obDateStore[$fieldName_t].type="number")
			Case of 
				: ($fieldName_t="DT@")
					
				: ($vtColumnName="@time@")
					$width:=70
					$align:=Align center:K42:3
					$align_t:="center"
				: ($obDateStore[$fieldName_t].fieldType=Is real:K8:4)
					//LISTBOX SET PROPERTY(*; $vtColumnName; lk display type; lk numeric format)
					$width:=80
					$align:=Align right:K42:4
					$align_t:="right"
					$format:="###,###,###,##0.00"
					//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
				Else 
					//LISTBOX SET PROPERTY(*; $vtColumnName; lk display type; lk numeric format)
					$width:=80
					$align:=Align right:K42:4
					$align_t:="right"
					$format:="###,###,###,##0"
			End case 
			
		: ($obDateStore[$fieldName_t].type="string")
			Case of 
				: (($fieldName_t="@phone@") | ($fieldName_t="@fax@"))
					$format:="### ### (###) ###-####"
				Else 
			End case 
	End case 
	
	var $vtTitle : Text
	$vtTitle:=Uppercase:C13($fieldName_t[[1]])+Substring:C12($fieldName_t; 2; Length:C16($fieldName_t))
	//  $colObj:=New object("name"; $vtColumnName
	$colObj:=New object:C1471("objectName"; $vtColumnName; \
		"width"; $width; \
		"dataSource"; "This."+$fieldName_t; \
		"header"; New object:C1471("name"; $vtColumnName; "text"; $vtTitle); \
		"footer"; New object:C1471("name"; $vtFooter); \
		"textAlign"; $align_t; \
		"align"; $align; \
		"format"; $format; \
		"fieldType"; $obDateStore[$fieldName_t].fieldType)
	
	$obj.columns.push($colObj)
	
End for each 

//$obj.events.push($listboxSetup_o.events)

$page:=New object:C1471("objects"; New object:C1471($lbName_t; $obj))
$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))


jsonText:=JSON Stringify:C1217($form; *)
jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($form))
var $ptData : Pointer

var $tableNum; $fieldNum : Integer
$tableNum:=STR_GetTableNumber($tableName)
$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
RESOLVE POINTER:C394($ptData; $colName; $tableNum; $fieldNum)

$0:=$form
//$ptData:=Get pointer("Form."+$lbName_t+".ents")
//$ptData->:=ds[$tableName].all()


// $form:=LBX_DemoDynamic_02(1; ->[Customer]; ->$nCol)  // Selection based




