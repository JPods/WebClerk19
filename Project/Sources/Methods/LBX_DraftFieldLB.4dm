//%attributes = {}

// Modified by: Bill James (2021-12-26T06:00:00Z)
// Method: LBX_DraftFieldLB
// Description 
// Parameters
// ----------------------------------------------------


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
"method"; $lbName_t+".4dm"; \
"metaSource"; $lbName_t+".meta"; \
"dataSource"; $lbName_t+".ents"; \
"currentItemSource"; $lbName_t+".cur"; \
"currentItemPositionSource"; $lbName_t+".pos"; \
"selectedItemsSource"; $lbName_t+".sel"; \
"left"; 0; "top"; 0; \
"width"; $width+15; "height"; $height; \
"events"; New collection:C1472; \
"columns"; New collection:C1472)



var $cBuild; $cFilter : Collection
var $obField : Object
$cBuild:=New collection:C1472
Case of 
	: (Form:C1466.LB_Fields.sel#Null:C1517)
		For each ($obField; Form:C1466.LB_Fields.sel)
			$cBuild.push($obField.fieldName)
		End for each 
	: ($listboxSetup_o.fieldList#Null:C1517)
		$cBuild:=Split string:C1554($listboxSetup_o.fieldList; ",")
	Else 
		$cBuild:=Split string:C1554("company,address1,actionDate"; ",")
End case 
If ($cBuild.length=0)  // for covienence
	$cBuild:=Split string:C1554("company,address1,actionDate"; ",")
End if 


$fieldList_t:=$cBuild.join(",")
$viCnt:=$cBuild.length


// define standard events
// look at options for this
If ($listboxSetup_o.events=Null:C1517)
	$listboxSetup_o.events:=Split string:C1554("onLoad,onClick,onDataChange,onSelectionChange"; ",")
End if 

// set the events
$listbox_o.events.push($listboxSetup_o.events)

// make columns
var $colObj : Object
// get the datastore for this table
$obDateStore:=ds:C1482[$tableName]

// "dataSource"; "Form."+$lbName_t+".ents"; 
var dataTest : Object
dataTest:=ds:C1482[$tableName].all()

$obDateStore:=ds:C1482[$tableName]


For each ($fieldName_t; $cBuild)
	$colObj:=New object:C1471
	
	//$vtColumnName:=$lbName_t+"_"+$fieldName_t
	$vtColumnName:="Column_"+$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$vtColumnName:=$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$vtHeader:="Header_"+$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$vtFooter:="Footer_"+$lbName_t+"_"+$fieldName_t+"_"+$columnAdder_t
	$ptHeaderVar:=$NilPtr  // Get pointer($vtHeader)
	$vtColumnFormula:="This."+$fieldName_t
	
	$width:=120
	$align:=Align left:K42:2
	$align_t:="left"
	$format:=""
	$enterable:=False:C215
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
	//"objectName"; $vtColumnName; 
	$colObj:=New object:C1471("name"; $vtColumnName; \
		"width"; $width; \
		"dataSource"; "This."+$fieldName_t; \
		"header"; New object:C1471("name"; $vtColumnName; "text"; $vtTitle); \
		"footer"; New object:C1471("name"; $vtFooter); \
		"textAlign"; $align_t; \
		"align"; $align; \
		"format"; $format; \
		"enterable"; $enterable; \
		"fieldType"; $obDateStore[$fieldName_t].fieldType)
	
	$listbox_o.columns.push($colObj)
	
End for each 

$page:=New object:C1471("objects"; New object:C1471($lbName_t; $listbox_o))
$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))

jsonText:=JSON Stringify:C1217($form; *)
jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")

// SET TEXT TO PASTEBOARD(JSON Stringify($form))


$0:=$form



