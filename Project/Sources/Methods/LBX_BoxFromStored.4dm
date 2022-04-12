//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/04/21, 00:01:49
// ----------------------------------------------------
// Method: LBX_BoxFromStored
// Description
// 
// Parameters
//  QQQ Look at LBX_ColumnHarvest to add more features. 
// LBXDraftForm.bGetListBox
// ----------------------------------------------------


var $lbName_t; $tableName; $columnAdder_t : Text
var $1; $listboxSetup_o; $columnSetup_o : Object
var $viCnt; $viInc : Integer
var $oneField_o; $fields_o : Object
var $name_c : Collection

$listboxSetup_o:=$1
$lbName_t:=$listboxSetup_o.listboxName
$tableName:=$listboxSetup_o.tableName
$columnSetup_o:=$listboxSetup_o.columns

var $NilPtr : Pointer


$viCnt:=LISTBOX Get number of columns:C831(*; $lbName_t)
If ($viCnt>0)
	LISTBOX DELETE COLUMN:C830(*; $lbName_t; 1; $viCnt)
End if 
var $columns_c : Collection
$columns_c:=New collection:C1472

$obDateStore:=ds:C1482[$tableName]
For each ($vtProperty; $columnSetup_o)  //["0"]....
	var column_o : Object
	column_o:=$columnSetup_o[$vtProperty].column
	$columnName_t:=column_o.name
	If (column_o.fieldName=Null:C1517)
		$name_c:=Split string:C1554($columnName_t; "_")
		$fieldName_t:=$name_c[2]
	Else 
		$fieldName_t:=column_o.fieldName
	End if 
	If (column_o.fieldType=Null:C1517)  // retrofit existing defaults   
		column_o.fieldType:=$obDateStore[$fieldName_t].fieldType
	End if 
	If (column_o.fieldType=Null:C1517)
		ConsoleMessage($tableName+" cannot creae column/field: "+column_o.name)
	Else 
		
		$headerName_t:=$columnSetup_o[$vtProperty].header.name
		$footerName_t:=$columnSetup_o[$vtProperty].footer.name
		$viCount:=Num:C11($vtProperty)
		
		//  $columnName_t:="Column_"+$tableName+"_"+$fieldName_t+"_"+$columnAdder_t
		//  $headerName_t:="Header_"+$tableName+"_"+$fieldName_t+"_"+$columnAdder_t
		
		
		// //$obColumn.column.formula:=LISTBOX Get column formula(*; $arrLBObjects{$incOb})
		// // $obColumn.column.displayType:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk display type)
		LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName_t; Num:C11($vtProperty)+1; column_o.name; column_o.formula; column_o.fieldType; $headerName_t; $NilPtr; $footerName_t; $NilPtr)
		var $vtTitle : Text
		$vtTitle:=Uppercase:C13($fieldName_t[[1]])+Substring:C12($fieldName_t; 2; Length:C16($fieldName_t))
		OBJECT SET TITLE:C194(*; $headerName_t; $vtTitle)
		If (column_o.width#Null:C1517)
			LISTBOX SET COLUMN WIDTH:C833(*; $columnName_t; column_o.width)
			//$obColumn.column.width:=LISTBOX Get column width(*; $arrLBObjects{$incOb})
		End if 
		If (column_o.format#Null:C1517)
			OBJECT SET FORMAT:C236(*; $columnName_t; column_o.format)
			//$obColumn.column.format:=OBJECT Get format(*; $arrLBObjects{$incOb})  // 1
		End if 
		If (column_o.align#Null:C1517)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $columnName_t; column_o.align)
			//$obColumn.column.align:=OBJECT Get horizontal alignment(*; $arrLBObjects{$incOb})
		End if 
		If (column_o.wordWrap#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk allow wordwrap:K53:39; column_o.wordWrap)
			// $obColumn.column.wordWrap:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk allow wordwrap)
		End if 
		If (column_o.bgColor#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk background color expression:K53:47; column_o.bgColor)
			// $obColumn.column.bgColor:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk background color expression)
		End if 
		If (column_o.fontColor#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk font color expression:K53:48; column_o.fontColor)
			//$obColumn.column.fontColor:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk font color expression)
		End if 
		If (column_o.widthMin#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk column min width:K53:50; column_o.widthMin)
			// $obColumn.column.widthMin:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk column min width)
		End if 
		If (column_o.widthMax#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk column max width:K53:51; column_o.widthMax)
			//$obColumn.column.widthMax:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk column max width)
		End if 
		If (column_o.displayType#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk display type:K53:46; column_o.displayType)
			//  Display Type property for numeric columns
			//  $obColumn.column.displayType:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk display type)
		End if 
		If (column_o.resizable#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk column resizable:K53:40; column_o.resizable)
			// $obColumn.column.resizable:=LISTBOX Get property(*; $arrLBObjects{$incOb}; lk column resizable)
		End if 
		
		//  More values   https://doc.4d.com/4Dv19/4D/19/LISTBOX-SET-PROPERTY.301-5392643.en.html
		// 
	End if 
	$columns_c.push(column_o)
End for each 
//$1.columns:=$columns_c
//$0:=$listboxSetup_o