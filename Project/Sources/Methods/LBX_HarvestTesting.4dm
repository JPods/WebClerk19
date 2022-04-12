//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/04/21, 23:05:59
// ----------------------------------------------------
// Method: LBX_HarvestTesting
// Description
// 
// Parameters
// ----------------------------------------------------

var $0; $listbox_o : Object
var $columns_c : Collection
var $lbName; $1 : Text
If (Count parameters:C259=0)
	$lbName:="LBImport"
Else 
	$lbName:=$1
End if 

var $ptSource : Pointer
var $format : Text

var $lbName : Text

$listbox_o:=New object:C1471
$listbox_o.name:=$lbName

ARRAY TEXT:C222($arrColNames; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY POINTER:C280($arrColVars; 0)
ARRAY POINTER:C280($arrHeaderVars; 0)
ARRAY BOOLEAN:C223($arrColsVisible; 0)
ARRAY POINTER:C280($arrStyles; 0)
ARRAY TEXT:C222($arrFooterNames; 0)
ARRAY POINTER:C280($arrFooterVars; 0)
LISTBOX GET ARRAYS:C832(*; $lbName; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)


var $viScrollHorizontal; $viScrollVertical : Integer
//$listbox_o.scroll:=OBJECT GET SCROLLBAR(*; $lbName; $viScrollHorizontal; $viScrollVertical)
//$listbox_o.scrollPosition:=OBJECT GET SCROLL POSITION(*; $lbName; $viScrollHorizontal; $viScrollVertical)
$listbox_o.scrollbarHeight:=LISTBOX Get property:C917(*; $lbName; lk hor scrollbar height:K53:7)
$listbox_o.footerHeight:=LISTBOX Get footers height:C1146(*; $lbName; lk hor scrollbar height:K53:7)
$listbox_o.headerHeight:=LISTBOX Get headers height:C1144(*; $lbName; lk hor scrollbar height:K53:7)
$listbox_o.backGroundColor:=LISTBOX Get property:C917(*; $lbName; lk background color expression:K53:47)
$listbox_o.detailFormName:=LISTBOX Get property:C917(*; $lbName; lk detail form name:K53:44)
$listbox_o.displayFooter:=LISTBOX Get property:C917(*; $lbName; lk display footer:K53:20)
$listbox_o.displayHeader:=LISTBOX Get property:C917(*; $lbName; lk display header:K53:4)
$listbox_o.clickDouble:=LISTBOX Get property:C917(*; $lbName; lk double click on row:K53:43)
$listbox_o.extraRows:=LISTBOX Get property:C917(*; $lbName; lk extra rows:K53:38)
$listbox_o.fontColor:=LISTBOX Get property:C917(*; $lbName; lk font color expression:K53:48)
$listbox_o.hideSelection:=LISTBOX Get property:C917(*; $lbName; lk hide selection highlight:K53:41)
$listbox_o.highlightSet:=LISTBOX Get property:C917(*; $lbName; lk highlight set:K53:66)



var $cListBoxColumns : Collection

$cListBoxColumns:=New collection:C1472

var $obColumn : Object
ARRAY TEXT:C222($arrLBObjects; 0)
LISTBOX GET OBJECTS:C1302(*; $lbName; $arrLBObjects)
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
			$obColumn.alignCode:=OBJECT Get horizontal alignment:C707(*; $obColumn.name)
			$obColumn.formatStr:=OBJECT Get format:C894(*; $obColumn.name)  // 1
			$obColumn.formatStr:=OBJECT Get format:C894(*; $obColumn.name)  // 1
			$vtColString:=Substring:C12($obColumn.name; Position:C15("_"; $obColumn.name)+1)
			$obColumn.width:=LISTBOX Get column width:C834(*; $obColumn.name)
			$obColumn.formula:=LISTBOX Get column formula:C1202(*; $obColumn.name)
			$obColumn.displayType:=LISTBOX Get property:C917(*; $obColumn.name; lk display type:K53:46)
			$obColumn.wordWrap:=LISTBOX Get property:C917(*; $obColumn.name; lk allow wordwrap:K53:39)
			$obColumn.backGroundColor:=LISTBOX Get property:C917(*; $obColumn.name; lk background color expression:K53:47)
			$listbox_o.widthMin:=LISTBOX Get property:C917(*; $obColumn.name; lk column min width:K53:50)
			$listbox_o.widthMax:=LISTBOX Get property:C917(*; $obColumn.name; lk column max width:K53:51)
			$listbox_o.displayType:=LISTBOX Get property:C917(*; $obColumn.name; lk display type:K53:46)
			$listbox_o.resizable:=LISTBOX Get property:C917(*; $obColumn.name; lk column resizable:K53:40)
			$listbox_o.fontColor:=LISTBOX Get property:C917(*; $obColumn.name; lk font color expression:K53:48)
			
			
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
			//$cListBoxColumns.push(New object($vtCounter; $obColumn))
			$cListBoxColumns.push($obColumn)
	End case 
End for 

$listbox_o.countColumns:=$cListBoxColumns.length
$listbox_o.columns:=New object:C1471("columns"; $cListBoxColumns)
$0:=$listbox_o


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

If (False:C215)
	
	$doRebuild:=False:C215
	If ($doRebuild)
		
		var $viCnt; $viInc : Integer
		$viCnt:=LISTBOX Get number of columns:C831(*; $lbName)
		If ($viCnt>0)
			LISTBOX DELETE COLUMN:C830(*; $lbName; 1; $viCnt)
		End if 
		
		$obDateStore:=ds:C1482[tableName]
		var $NilPtr : Pointer
		var $tableName; $vtCounter; $vtFieldName : Text
		var $colCounter; $viCount; $viType : Integer
		var $cField : Collection
		For each ($vtCounter; $obListSetup)
			$colCounter:=Num:C11($vtCounter)
			$viCount:=$viCount+1  // these should match
			$vtColumnName:=$obListSetup[$vtCounter].column.name
			$cField:=Split string:C1554($vtColumnName; "_")
			ARRAY TEXT:C222($atNameSplit; 0)
			COLLECTION TO ARRAY:C1562($cField; $atNameSplit)
			If ($cField.length=3)  // zero element
				$vtFieldName:=$atNameSplit{3}
				$tableName:=$atNameSplit{2}
			Else 
				$vtFieldName:=$atNameSplit{2}
			End if 
			
			$vtColumnFormula:=$obListSetup[$vtCounter].column.formula
			$viType:=$obDateStore[$vtFieldName].fieldType
			$vtHeader:=$obListSetup[$vtCounter].header.name
			$vtTitle:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
			
			LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName; $viCount; $vtColumnName; $vtColumnFormula; $viType; $vtHeader; $NilPtr)
			LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; $obListSetup[$vtCounter].column.width)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; $obColumn.alignCode)
			OBJECT SET FORMAT:C236(*; $vtColumnName; $obColumn.formatStr)  // 1
			
			
			$vtTitle:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
			OBJECT SET TITLE:C194(*; $vtHeader; $vtTitle)
			
		End for each 
		
	End if 
	
End if 
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