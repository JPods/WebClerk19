//%attributes = {}

// Modified by: Bill James (2021-12-26T06:00:00Z)
// Method: LBX_DraftFieldLB
// Description 
// Parameters
// ----------------------------------------------------
// QQQZZZ Delete this method

var $sfName_t; $lbName_t; $tableName; $columnAdder_t; $stringType_t; $align_t; $dateSource : Text
var $form; $0; $1; $listboxSetup_o; $columnSetup_o : Object
var $viCnt; $viInc; $fieldType_i : Integer
var $oneField_o; $fields_o : Object


// setup the ListBox
$listboxSetup_o:=$1
// setup below
$lbName_t:=$listboxSetup_o.listboxName
$tableName:=$listboxSetup_o.tableName

If (False:C215)
	// if using Form
	Form:C1466[$lbName_t]:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1)
	
	// if using the LB_name, it must be passed into the calling Dialog call
End if 

//If ($listboxSetup_o.subForm#Null)
//$sfName_t:=$listboxSetup_o.subForm
//Else 
//$sfName_t:="Subform"
//End if 

// container to receive the listbox
// get coordinates for the subform
OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; "SF_Draft"))->; $left; $top; $right; $bottom)
$width:=$right-$left
$height:=$bottom-$top



// setup the list box basics
var $listbox_o : Object
// $listbox_o:=New object("type"; "listbox"; \
"listboxType"; "collection"; \
"method"; "Form."+$lbName_t; \
"metaSource"; "Form."+$lbName_t; \
"dataSource"; "Form."+$lbName_t+".ents"; \
"currentItemSource"; "Form."+$lbName_t+".cur"; \
"currentItemPositionSource"; "Form."+$lbName_t+".pos"; \
"selectedItemsSource"; "Form."+$lbName_t+".sel"; \
"left"; 0; "top"; 0; \
"width"; $width+15; "height"; $height; \
"events"; New collection; \
"columns"; New collection)

$listbox_o:=New object:C1471("type"; "listbox"; \
"listboxType"; "collection"; \
"method"; "Form."+$lbName_t+".4dm"; \
"metaSource"; "Form."+$lbName_t+".meta"; \
"dataSource"; "Form."+$lbName_t+".ents"; \
"currentItemSource"; "Form."+$lbName_t+".cur"; \
"currentItemPositionSource"; "Form."+$lbName_t+".pos"; \
"selectedItemsSource"; "Form."+$lbName_t+".sel"; \
"left"; 0; "top"; 0; \
"width"; $width+15; "height"; $height; \
"events"; New collection:C1472; \
"columns"; New collection:C1472)


LISTBOX SET PROPERTY:C1440(*; "LB3"; lk truncate:K53:37; lk without ellipsis:K53:64)

var $cBuild; $cFilter : Collection
var $obField : Object
$cBuild:=New collection:C1472
Case of 
	: (Form:C1466.LB_Fields.sel#Null:C1517)
		For each ($obField; Form:C1466.LB_Fields.sel)
			$cBuild.push($obField.fieldName)
		End for each 
	: ($listboxSetup_o.fieldList#Null:C1517)
		$cBuild:=Split string:C1554($listboxSetup_o.fieldList; ";")
	Else 
		$cBuild:=Split string:C1554("company,address1,actionDate"; ";")
End case 
If ($cBuild.length=0)  // for covienence
	$cBuild:=Split string:C1554("company,address1,actionDate"; ";")
End if 


$fieldList_t:=$cBuild.join(";")
$viCnt:=$cBuild.length


// define standard events
// look at options for this
If ($listboxSetup_o.events=Null:C1517)
	$listboxSetup_o.events:=Split string:C1554("onLoad,onClick,onDataChange,onSelectionChange"; ";")
End if 

// set the events
$listbox_o.events:=$listboxSetup_o.events

// make columns
var $colObj : Object
// get the datastore for this table
$obDateStore:=ds:C1482[$tableName]

// "dataSource"; "Form."+$lbName_t+".ents"; 
var dataTest : Object
dataTest:=ds:C1482[$tableName].all()

$obDateStore:=ds:C1482[$tableName]


For each ($fieldName_t; $cBuild)
	$column_o:=LBX_ColumnFromName(Form:C1466.dataClassName; $field)
	LBX_ColumnFromName
	LBX_ColumnSet
	
	$listbox_o.columns.push($colObj)
	
End for each 




$page:=New object:C1471("objects"; New object:C1471($lbName_t; $listbox_o))
$form:=New object:C1471("pages"; New collection:C1472(New object:C1471("objects"; New object:C1471); $page))

jsonText:=JSON Stringify:C1217($form; *)
jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")

// SET TEXT TO PASTEBOARD(JSON Stringify($form))


$0:=$form



