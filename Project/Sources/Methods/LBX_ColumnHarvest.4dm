//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/03/21, 00:05:36
// ----------------------------------------------------
// Method: LBX_ColumnHarvest
// REF: LBX_ColumnBuild 
// 
// Parameters
// ----------------------------------------------------

var $listboxHarvest_o; $0 : Object
$listboxHarvest_o:=$1
var $lbName_t; $tableName : Text
$lbName_t:=$listboxHarvest_o.listboxName
$tableName:=$listboxHarvest_o.tableName


ARRAY TEXT:C222($arrColNames; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY POINTER:C280($arrColVars; 0)
ARRAY POINTER:C280($arrHeaderVars; 0)
ARRAY BOOLEAN:C223($arrColsVisible; 0)
ARRAY POINTER:C280($arrStyles; 0)
ARRAY TEXT:C222($arrFooterNames; 0)
ARRAY POINTER:C280($arrFooterVars; 0)
LISTBOX GET ARRAYS:C832(*; $lbName_t; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)


var $listboxSetup_o : Object
$listboxSetup_o:=New object:C1471("listboxName"; $lbName_t; "tableName"; tableName; "fieldList"; ""; "priority"; "harvest"; "role"; ""; "idUser"; ""; "columns"; New object:C1471)

var $viScrollHorizontal; $viScrollVertical : Integer
//$listboxSetup_o.scroll:=OBJECT GET SCROLLBAR(*; $lbName_t; $viScrollHorizontal; $viScrollVertical)
//$listboxSetup_o.scrollPosition:=OBJECT GET SCROLL POSITION(*; $lbName_t; $viScrollHorizontal; $viScrollVertical)
$listboxSetup_o.scrollbarHeight:=LISTBOX Get property:C917(*; $lbName_t; lk hor scrollbar height:K53:7)
//$listboxSetup_o.footerHeight:=LISTBOX Get footers height
//$listboxSetup_o.headerHeight:=LISTBOX Get headers height
$listboxSetup_o.backGroundColor:=LISTBOX Get property:C917(*; $lbName_t; lk background color expression:K53:47)
$listboxSetup_o.detailFormName:=LISTBOX Get property:C917(*; $lbName_t; lk detail form name:K53:44)
$listboxSetup_o.displayFooter:=LISTBOX Get property:C917(*; $lbName_t; lk display footer:K53:20)
$listboxSetup_o.displayHeader:=LISTBOX Get property:C917(*; $lbName_t; lk display header:K53:4)
$listboxSetup_o.clickDouble:=LISTBOX Get property:C917(*; $lbName_t; lk double click on row:K53:43)
$listboxSetup_o.extraRows:=LISTBOX Get property:C917(*; $lbName_t; lk extra rows:K53:38)
$listboxSetup_o.fontColor:=LISTBOX Get property:C917(*; $lbName_t; lk font color expression:K53:48)
$listboxSetup_o.hideSelection:=LISTBOX Get property:C917(*; $lbName_t; lk hide selection highlight:K53:41)
$listboxSetup_o.highlightSet:=LISTBOX Get property:C917(*; $lbName_t; lk highlight set:K53:66)



//var $columns_c : Collection

//$columns_c:=New collection

var $obColumn; $lbWhole_o : Object
//$lbWhole_o:=LBDraftTable
ARRAY TEXT:C222($arrLBObjects; 0)
LISTBOX GET OBJECTS:C1302(*; $lbName_t; $arrLBObjects)
var $cntOb; $incOb; $viWidth : Integer
$cntOb:=Size of array:C274($arrLBObjects)
var $cntColumns_i : Integer
$cntColumns_i:=-1
var $obColumn; $obFooter; $obHeader : Object
var $footerName; $headerName : Text
var $columns_c : Collection
$columns_c:=New collection:C1472
For ($incOb; 1; $cntOb)
	Case of 
		: ($arrLBObjects{$incOb}="Column_@")
			$cntColumns_i:=$cntColumns_i+1
			
			var $header_c : Collection
			$header_c:=Split string:C1554($arrLBObjects{$incOb}; "_")
			$vtColString:=Substring:C12($arrLBObjects{$incOb}; Length:C16("Column")+1)
			
			// $obColumn:=New object("header"; ""; "column"; ""; "footer"; ""; "align"; -1; "format"; ""; "width"; -1; "formula"; ""; "displayType"; -1; "wordWrap"; -1; "bgColor"; -1; "fontColor"; -1; "widthMin"; -1; "widthMax"; -1; "resizable"; -1)
			$obColumn:=New object:C1471("header"; New object:C1471; "footer"; New object:C1471)
			
			
			$obColumn.name:=$arrLBObjects{$incOb}
			$begin_i:=Position:C15("_"; $obColumn.name; 14)+1
			$end_i:=Position:C15("_"; $obColumn.name; $begin_i)
			$vtFieldName:=Substring:C12($obColumn.name; $begin_i; $end_i-$begin_i)
			
			$obColumn.header.name:="Header"+$vtColString
			$obColumn.header.text:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
			$headerName:=$obColumn.header.name
			$obColumn.footer.name:="Footer"+$vtColString
			$footerName:=$obColumn.footer.name
			
			//""; "align"; -1; "format"; ""; "width"; -1; "formula"; ""; "displayType"; -1; "wordWrap"; -1; "bgColor"; -1; "fontColor"; -1; "widthMin"; -1; "widthMax"; -1; "resizable"; -1)
			
			
			$obColumn.className:=$header_c[1]
			$obColumn.valueName:=$header_c[2]
			$obColumn.align:=OBJECT Get horizontal alignment:C707(*; $arrLBObjects{$incOb})
			$obColumn.format:=OBJECT Get format:C894(*; $arrLBObjects{$incOb})  // 1
			$obColumn.width:=LISTBOX Get column width:C834(*; $arrLBObjects{$incOb})
			$obColumn.formula:=LISTBOX Get column formula:C1202(*; $arrLBObjects{$incOb})
			$obColumn.dataSource:="This:C1470."+$vtFieldName
			$obColumn.displayType:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk display type:K53:46)
			$obColumn.wordWrap:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk allow wordwrap:K53:39)
			$obColumn.bgColor:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk background color expression:K53:47)
			$obColumn.fontColor:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk font color expression:K53:48)
			$obColumn.widthMin:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column min width:K53:50)
			$obColumn.widthMax:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column max width:K53:51)
			$obColumn.displayType:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk display type:K53:46)
			$obColumn.resizable:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column resizable:K53:40)
			
			// is this valid, is the footer always last for each column?
			var $vtCounter : Text
			$vtCounter:=String:C10($cntColumns_i)
			$columns_c.push($obColumn)
			//$columns_c.push(New object($vtCounter; $obColumn))
			// gather any column specifics, what are they??
			
		: ($arrLBObjects{$incOb}="Head@")  //  avoiding null, may not be required   $obColumn.header.name)
			If (False:C215)  // should already be done
				$listboxSetup_o.columns[$vtCounter].header.name:="Header"+$vtColString
			End if 
			// taken care of in $obColumn.name
			//$obHeader:=New object
			// $obColumn.header:="Header_"+$vtColString
			
			//$obHeader:=$obColumn
			// gather any header specifics, what are they??
			
			//$listboxSetup_o.columns[$vtCounter].header:="Header_"+$vtColString
			
			
		: ($arrLBObjects{$incOb}="Footer@")  //  avoiding null, may not be required $obColumn.footer.name)
			If (False:C215)  // should already be done
				$listboxSetup_o.columns[$vtCounter].footer.name:="Footer"+$vtColString
			End if 
			//$cntColumns_i:=$cntColumns_i+1
			//$obColumn.footer:="Footer_"+$vtColString
			//  gather any footer specifics, what are they??
			
			
	End case 
End for 
$listboxSetup_o.columns:=$columns_c
var $cnt : Integer

$cnt:=$listboxSetup_o.columns.length
$0:=$listboxSetup_o








$doRebuild:=False:C215
If ($doRebuild)
	
	var $viCnt; $viInc : Integer
	$viCnt:=LISTBOX Get number of columns:C831(*; $lbName_t)
	If ($viCnt>0)
		LISTBOX DELETE COLUMN:C830(*; $lbName_t; 1; $viCnt)
	End if 
	
	$obDateStore:=ds:C1482[tableName]
	var $NilPtr : Pointer
	var $tableName; $vtCounter; $vtFieldName : Text
	var $cntColumns_i; $viCount; $viType : Integer
	var $cField : Collection
	
	For each ($vtCounter; $obListSetup)
		$cntColumns_i:=Num:C11($vtCounter)
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
		
		LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName_t; $viCount; $vtColumnName; $vtColumnFormula; $viType; $vtHeader; $NilPtr)
		LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; $obListSetup[$vtCounter].column.width)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; $obColumn.alignCode)
		OBJECT SET FORMAT:C236(*; $vtColumnName; $obColumn.formatStr)  // 1
		
		
		$vtTitle:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
		OBJECT SET TITLE:C194(*; $vtHeader; $vtTitle)
		
	End for each 
	
End if 

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



///////////////////////////////



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