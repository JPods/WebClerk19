//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/06/21, 16:45:17
// ----------------------------------------------------
// Method: LB_GetColumnObject
// Description
// 
//
// Parameters
// ----------------------------------------------------


//<code 4D>
//Method LISTBOX get clicked header col

C_OBJECT:C1216($0)  //Object containing Column, ColumnName, HeaderName
C_TEXT:C284($1; $2)  //Listbox Name


C_POINTER:C301($p_HeaderVar)
C_TEXT:C284($t_ListboxName; $tableName)

$0:=New object:C1471
$t_ListboxName:=$1
$tableName:=$2

// get the objects in the ListBox
ARRAY OBJECT:C1221($arrLBObjects; 0)
//LISTBOX GET OBJECTS(*; $t_ListboxName; $arrLBObjects)

ARRAY TEXT:C222($at_ColNames; 0)
ARRAY TEXT:C222($at_ColNames; 0)
ARRAY TEXT:C222($at_HeaderNames; 0)
ARRAY POINTER:C280($ap_ColVars; 0)
ARRAY POINTER:C280($ap_HeaderVars; 0)
ARRAY BOOLEAN:C223($ab_ColVisible; 0)
ARRAY POINTER:C280($ap_Styles; 0)
LISTBOX GET ARRAYS:C832(*; $t_ListboxName; $at_ColNames; $at_HeaderNames; $ap_ColVars; $ap_HeaderVars; $ab_ColVisible; $ap_Styles)

If ($t_ListboxName=Null:C1517)
	$0:=New object:C1471
Else 
	$viCol:=LISTBOX Get number of columns:C831(*; $t_ListboxName)
	C_OBJECT:C1216($obListBoxSet)
	$obListBoxSet:=New object:C1471("listboxName"; $t_ListboxName; "columnCount"; $viCol; "columns"; ""; "textNames"; "")
	
	C_COLLECTION:C1488($cCollumns)
	$cCollumns:=New collection:C1472
	C_POINTER:C301($ptNil)
	C_OBJECT:C1216($obColumn)
	C_TEXT:C284($vtNames)
	For ($inc; 1; $viCol)
		$obColumn:=New object:C1471("columnNum"; $inc; "columnName"; ""; "headerName"; ""; "ptColVars"; $ptNil; "ptHeaderVars"; $ptNil)
		//$obColumn:=New object("columnName"; ""; "headerName"; ""; "ptColVars"; $ptNil; "ptHeaderVars"; $ptNil; "booVisible"; True)
		
		$obColumn.columnName:=$at_ColNames{$inc}
		$vtNames:=$vtNames+$at_ColNames{$inc}+","
		
		$w:=Find in array:C230($arrLBObjects; $at_ColNames{$inc})
		C_LONGINT:C283($viColumnWidth)
		If ($w>0)
			//$viColumnWidth:=LISTBOX Get column width(*; $arrLBObjects{$w})
			$viColumnWidth:=LISTBOX Get column width:C834(*; $at_ColNames{$w})
			$obColumn.width:=$viColumnWidth
		End if 
		
		$obColumn.headerName:=$at_HeaderNames{$inc}
		$obColumn.booVisible:=New object:C1471
		$obColumn.booVisible:=$ab_ColVisible{$inc}
		//C_OBJECT($obWidth)
		//$obWidth:=New object
		//$cCollumn.width:=LISTBOX Get column width($obColumn.columnName)
		$cCollumns.push($obColumn)
	End for 
	$vtNames:=Substring:C12($vtNames; 1; Length:C16($vtNames)-1)
End if 
$vtNames:=LB_TextStringAddID($vtNames)
$obListBoxSet.textNames:=$vtNames
$obListBoxSet.columns:=$cCollumns
$obListBoxSet.tableName:=$tableName
$0:=$obListBoxSet
//</code 4D>