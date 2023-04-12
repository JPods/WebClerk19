

var $ptSource : Pointer
//$ptSource:=OBJECT Get data source(*; "LBImport")
//$cListBoxColumns.events:=OBJECT GET EVENTS(*; "LBImport")
//$cListBoxColumns.dataSource:=
//$cListBoxColumns.currentItemSource:=OBJECT GET EVENTS(*; arrObjects{$i})
//$cListBoxColumns.currentItemSource:=OBJECT GET EVENTS(*; arrObjects{$i})
//$cListBoxColumns.currentItemSource:=OBJECT GET EVENTS(*; arrObjects{$i})

var $format_t : Text

var $listboxName_t : Text
$listboxName_t:="LBImport"
var $listbox_o : Object
$listbox_o:=New object:C1471
$listbox_o:=Form:C1466.obHarvest
var $viScrollHorizontal; $viScrollVertical : Integer

//$listbox_o.scroll:=OBJECT GET SCROLLBAR(*; $listboxName_t; $viScrollHorizontal; $viScrollVertical)
//$listbox_o.scrollPosition:=OBJECT GET SCROLL POSITION(*; $listboxName_t; $viScrollHorizontal; $viScrollVertical)
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk hor scrollbar height:K53:7; $listbox_o.scrollbarHeight)
//$listbox_o.footerHeight:=LISTBOX Get footers height
//$listbox_o.headerHeight:=LISTBOX Get headers height
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk background color expression:K53:47; $listbox_o.backGroundColor)
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk detail form name:K53:44; $listbox_o.detailFormName)
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk display footer:K53:20; $listbox_o.displayFooter)
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk display header:K53:4; $listbox_o.displayHeader)
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk double click on row:K53:43; $listbox_o.clickDouble)
LISTBOX SET PROPERTY:C1440(*; $listboxName_t; lk extra rows:K53:38; $listbox_o.extraRows)
$listbox_o.fontColor:=LISTBOX Get property:C917(*; $listboxName_t; lk font color expression:K53:48)
$listbox_o.hideSelection:=LISTBOX Get property:C917(*; $listboxName_t; lk hide selection highlight:K53:41)
$listbox_o.highlightSet:=LISTBOX Get property:C917(*; $listboxName_t; lk highlight set:K53:66)





var $viCnt; $viInc : Integer
$viCnt:=LISTBOX Get number of columns:C831(*; $listboxName_t)
If ($viCnt>0)
	LISTBOX DELETE COLUMN:C830(*; $listboxName_t; 1; $viCnt)
End if 

$obDateStore:=ds:C1482[tableName]
var $NilPtr : Pointer
var $tableName; $vtCounter; $vtFieldName : Text
var $colCounter; $viCount; $viType : Integer
var $cField : Collection
var $oneColumn_o : Object
$obListSetup:=Form:C1466.obHarvest.columns.columns
For each ($oneColumn_o; $obListSetup)
	
	//LBX_ColumnBuildOne($listboxName_t; $oneColumn_o)
	
End for each 



///   All columns resizing
//        LISTBOX SET PROPERTY(*; "LB6"; lk column resizable; lk yes)
///       LISTBOX SET PROPERTY(*; "LB6"; lk column resizable; lk no)

//   Specific column
//  LISTBOX SET PROPERTY(*; "P6_Col1"; lk column resizable; lk no)

//   Turn on and off highlight, note this is choice of hide (lk yes) and show (lk no)
//         LISTBOX SET PROPERTY(*; "LB7"; lk hide selection highlight; lk no)


//  what happens on doble click
//      opens record for edit, not sure if this works with collections, LISTBOX SET PROPERTY(*; "LB9"; lk double click on row; lk edit record)

//  Sets the input form for editing
//     LISTBOX SET PROPERTY(*; "LB10"; lk detail form name; vFormNameSet)
//      vFormNameGet:=LISTBOX Get property(*; "LB10"; lk detail form name)  gets the detailed form

//  Sets and get numeric format for the listbox or by column
///    LISTBOX SET PROPERTY(*; "LB12"; lk display type; lk numeric format)
///    LISTBOX SET PROPERTY(*; "LB12"; lk display type; lk three states checkbox)

///        LISTBOX SET PROPERTY(*; "LB12_Col1"; lk display type; lk numeric format)   //collumn

//    $display:=LISTBOX Get property(*; "LB12_Col1"; lk display type)
//    $display:=LISTBOX Get property(*; "LB12_Col2"; lk display type)

//   Set minimum width
//      LISTBOX SET PROPERTY(*; "LB16"; lk column min width; 50)  // or by column


//  Sets
//       LISTBOX SET PROPERTY(*; "LB18"; lk highlight set; "$SetA")
//       LISTBOX SET PROPERTY(*; "LB18"; lk highlight set; "$SetB")
//        $CR:=Char(Carriage return)
//
//        $setName:=LISTBOX Get property(*; "LB18"; lk highlight set)
//
//    If ($setName#"")
//    vResult:="highlight set: "+$setName
//    Else
//    vResult:="highlight set: none"
//    End if
//
//    vResult:=vResult+$cr+$cr
//    vResult:=vResult+"$SetA: "+String(Records in set("$SetA"))+" records"+$cr
//    vResult:=vResult+"$SetB: "+String(Records in set("$SetB"))+" records"+$cr

//  Nameing selection:
//      LISTBOX SET PROPERTY(*; "LB19"; lk named selection; "SelA")
//      LISTBOX SET PROPERTY(*; "LB19"; lk named selection; "SelB")
//      C_TEXT($selName)
//      $selName:=LISTBOX Get property(*; "LB19"; lk named selection)

//   Single Click Edit No:
//        LISTBOX SET PROPERTY(*; "LB22"; lk single click edit; lk no)
//   Single Click Edit Yes:
//       LISTBOX SET PROPERTY(*; "LB22"; lk single click edit; lk yes)
//
//           $result:=LISTBOX Get property(*; "LB22"; lk single click edit)
//           vResult:=Choose($result; "No"; "Yes")

//     Allowing multiple styles -- inventory levels
//         LISTBOX SET PROPERTY(*; "LB23"; lk multi style; lk yes)

//   Footers  hide and show
//      LISTBOX SET PROPERTY(*; "LB20"; lk display footer; lk no)
//      LISTBOX SET PROPERTY(*; "LB20"; lk display footer; lk yes)

//   Header  hide and show
//      LISTBOX SET PROPERTY(*; "LB21"; lk display header; lk no)
//      LISTBOX SET PROPERTY(*; "LB21"; lk display header; lk yes)

//   Get height of horizontal scroll bar
//       $result:=LISTBOX Get property(*; "LB28"; lk hor scrollbar height)
//       vResult:=String($result)

//   Get width of horizontal scroll bar
//       $result:=LISTBOX Get property(*; "LB29"; lk ver scrollbar width)
//       vResult:=String($result)


//  Randomly set background color
//    $expression:="Random"
//    LISTBOX SET PROPERTY(*; "LB13"; lk background color expression; $expression)

//  Randomly set background color
//      $expression:="SetColor(\"background\")"  // this is a method
///      LISTBOX SET PROPERTY(*; "LB13"; lk background color expression; $expression)
//       add the method SetColor

//        $expression:="0xFFA080"
//        LISTBOX SET PROPERTY(*; "LB13"; lk background color expression; $expression)
//        Need to do this by row based on inventory


//   Randomly set font style
//      $expression:="Random:C100%2"  //  plain (0) or bold (1)
//      LISTBOX SET PROPERTY(*; "LB15"; lk font style expression; $expression)

//   Sent font color by expression
//      $expression:="SetColor(\"fontstyle\")"  // this is a method
//      LISTBOX SET PROPERTY(*; "LB15"; lk font style expression; $expression)

//  Set font color
//      $expression:="Random"
//      LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)

//  Set font color
//      $expression:="Random"
//      LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)


//     $expression:="SetColor(\"fontcolor\")"  // this is a method
//     LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)

//     $expression:="0xFFA0A0"
//     LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)



If (False:C215)
	
	
	//$listbox_o.scroll:=OBJECT GET SCROLLBAR(*; $listboxName_t; $viScrollHorizontal; $viScrollVertical)
	//$listbox_o.scrollPosition:=OBJECT GET SCROLL POSITION(*; $listboxName_t; $viScrollHorizontal; $viScrollVertical)
	$listbox_o.scrollbarHeight:=LISTBOX Get property:C917(*; $listboxName_t; lk hor scrollbar height:K53:7)
	//$listbox_o.footerHeight:=LISTBOX Get footers height
	//$listbox_o.headerHeight:=LISTBOX Get headers height
	$listbox_o.backGroundColor:=LISTBOX Get property:C917(*; $listboxName_t; lk background color expression:K53:47)
	$listbox_o.detailFormName:=LISTBOX Get property:C917(*; $listboxName_t; lk detail form name:K53:44)
	$listbox_o.displayFooter:=LISTBOX Get property:C917(*; $listboxName_t; lk display footer:K53:20)
	$listbox_o.displayHeader:=LISTBOX Get property:C917(*; $listboxName_t; lk display header:K53:4)
	$listbox_o.clickDouble:=LISTBOX Get property:C917(*; $listboxName_t; lk double click on row:K53:43)
	$listbox_o.extraRows:=LISTBOX Get property:C917(*; $listboxName_t; lk extra rows:K53:38)
	$listbox_o.fontColor:=LISTBOX Get property:C917(*; $listboxName_t; lk font color expression:K53:48)
	$listbox_o.hideSelection:=LISTBOX Get property:C917(*; $listboxName_t; lk hide selection highlight:K53:41)
	$listbox_o.highlightSet:=LISTBOX Get property:C917(*; $listboxName_t; lk highlight set:K53:66)
	
	
	
	var $cListBoxColumns : Collection
	
	$cListBoxColumns:=New collection:C1472
	
	var $obColumn : Object
	ARRAY TEXT:C222($arrLBObjects; 0)
	LISTBOX GET OBJECTS:C1302(*; $listboxName_t; $arrLBObjects)
	var $cntOb; $incOb; $viWidth : Integer
	$cntOb:=Size of array:C274($arrLBObjects)
	var $colCounter : Integer
	var $obColumn; $obFooter; $obHeader : Object
	For ($incOb; 1; $cntOb)
		Case of 
			: ($arrLBObjects{$incOb}="Column_@")
				var $vtColString : Text
				$obColumn:=New object:C1471
				$obColumn.name:=$arrLBObjects{$incOb}
				$obColumn.alignCode:=OBJECT Get horizontal alignment:C707(*; $arrLBObjects{$incOb})
				$obColumn.formatStr:=OBJECT Get format:C894(*; $arrLBObjects{$incOb})  // 1
				$obColumn.formatStr:=OBJECT Get format:C894(*; $arrLBObjects{$incOb})  // 1
				$vtColString:=Substring:C12($obColumn.name; Position:C15("_"; $obColumn.name)+1)
				$obColumn.width:=LISTBOX Get column width:C834(*; $arrLBObjects{$incOb})
				$obColumn.formula:=LISTBOX Get column formula:C1202(*; $arrLBObjects{$incOb})
				$obColumn.displayType:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk display type:K53:46)
				$obColumn.wordWrap:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk allow wordwrap:K53:39)
				$obColumn.backGroundColor:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk background color expression:K53:47)
				$listbox_o.widthMin:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column min width:K53:50)
				$listbox_o.widthMax:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column max width:K53:51)
				$listbox_o.displayType:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk display type:K53:46)
				$listbox_o.resizable:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column resizable:K53:40)
				$listbox_o.fontColor:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk font color expression:K53:48)
				
				
				// gather any column specifics, what are they??
				
			: ($arrLBObjects{$incOb}="Header@")
				$obHeader:=New object:C1471
				$obColumn.header:="Header_"+$vtColString
				$obHeader:=$obColumn
				// gather any header specifics, what are they??
				
				
			: ($arrLBObjects{$incOb}="Footer@")
				$colCounter:=$colCounter+1
				$obColumn.footer:="Footer_"+$vtColString
				// gather any footer specifics, what are they??
				
				// is this valid, is the footer always last for each column?
				var $vtCounter : Text
				$vtCounter:=String:C10($colCounter)
				$cListBoxColumns.push(New object:C1471($vtCounter; $obColumn))
		End case 
	End for 
	
	
	
	$listbox_o.count:=$cListBoxColumns.length
	$listbox_o.columns:=New object:C1471("columns"; $cListBoxColumns)
	Form:C1466.obHarvest:=$listbox_o
	
End if 
/// QQQ

///   All columns resizing
//         LISTBOX SET PROPERTY(*; "LB6"; lk column resizable; lk yes)   //  ; lk column resizable; lk no
//    Specific column
//         LISTBOX SET PROPERTY(*; "P6_Col1"; lk column resizable; lk no)
//   Turn on and off highlight, note this is choice of hide (lk yes) and show (lk no)
//         LISTBOX SET PROPERTY(*; "LB7"; lk hide selection highlight; lk no)
//    What happens on doble click, opens record for edit, not sure if this works with collections,
//         LISTBOX SET PROPERTY(*; "LB9"; lk double click on row; lk edit record)
//   Sets the input form for editing
//         LISTBOX SET PROPERTY(*; "LB10"; lk detail form name; vFormNameSet)
//         vFormNameGet:=LISTBOX Get property(*; "LB10"; lk detail form name)  gets the detailed form
//  Sets format for the listbox or by column
//         LISTBOX SET PROPERTY(*; "LB12"; lk display type; lk numeric format)   //whole listbox
//         LISTBOX SET PROPERTY(*; "LB12"; lk display type; lk three states checkbox)   //whole listbox
///        LISTBOX SET PROPERTY(*; "LB12_Col1"; lk display type; lk numeric format)   //collumn
//         Cannot seem to find for time that works
//  Get format for the listbox or by column
//         $display:=LISTBOX Get property(*; "LB12_Col1"; lk display type)
//        $display:=LISTBOX Get property(*; "LB12_Col2"; lk display type)
//   Set minimum width
//      LISTBOX SET PROPERTY(*; "LB16"; lk column min width; 50)  // or by column

//    Sets
//        LISTBOX SET PROPERTY(*; "LB18"; lk highlight set; "$SetA")
//        LISTBOX SET PROPERTY(*; "LB18"; lk highlight set; "$SetB")
//        $CR:=Char(Carriage return)
//
//        $setName:=LISTBOX Get property(*; "LB18"; lk highlight set)
//

//   Single Click Edit No:
//        LISTBOX SET PROPERTY(*; "LB22"; lk single click edit; lk no)
//   Single Click Edit Yes:
//       LISTBOX SET PROPERTY(*; "LB22"; lk single click edit; lk yes)
//
//           $result:=LISTBOX Get property(*; "LB22"; lk single click edit)
//           vResult:=Choose($result; "No"; "Yes")

//     Allowing multiple styles -- inventory levels
//         LISTBOX SET PROPERTY(*; "LB23"; lk multi style; lk yes)

//   Footers  hide and show
//      LISTBOX SET PROPERTY(*; "LB20"; lk display footer; lk no)
//      LISTBOX SET PROPERTY(*; "LB20"; lk display footer; lk yes)

//   Header  hide and show
//      LISTBOX SET PROPERTY(*; "LB21"; lk display header; lk no)
//      LISTBOX SET PROPERTY(*; "LB21"; lk display header; lk yes)

//   Get height of horizontal scroll bar
//       $result:=LISTBOX Get property(*; "LB28"; lk hor scrollbar height)
//       vResult:=String($result)

//   Get width of horizontal scroll bar
//       $result:=LISTBOX Get property(*; "LB29"; lk ver scrollbar width)
//       vResult:=String($result)


//  Randomly set background color
//    $expression:="Random"
//    LISTBOX SET PROPERTY(*; "LB13"; lk background color expression; $expression)

//  Randomly set background color
//      $expression:="SetColor(\"background\")"  // this is a method
///      LISTBOX SET PROPERTY(*; "LB13"; lk background color expression; $expression)
//       add the method SetColor

//        $expression:="0xFFA080"
//        LISTBOX SET PROPERTY(*; "LB13"; lk background color expression; $expression)
//        Need to do this by row based on inventory


//   Randomly set font style
//      $expression:="Random:C100%2"  //  plain (0) or bold (1)
//      LISTBOX SET PROPERTY(*; "LB15"; lk font style expression; $expression)

//   Sent font color by expression
//      $expression:="SetColor(\"fontstyle\")"  // this is a method
//      LISTBOX SET PROPERTY(*; "LB15"; lk font style expression; $expression)

//  Set font color
//      $expression:="Random"
//      LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)

//  Set font color
//      $expression:="Random"
//      LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)


//     $expression:="SetColor(\"fontcolor\")"  // this is a method
//     LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)

//     $expression:="0xFFA0A0"
//     LISTBOX SET PROPERTY(*; "LB14"; lk font color expression; $expression)




