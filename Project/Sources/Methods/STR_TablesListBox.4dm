//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/01/21, 06:10:21
// ----------------------------------------------------
// Method: STR_TablesListBox
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($lb_Name : Text)
var $tableList_t : Text
If ($lb_Name="")
	$lb_Name:="LB_Tables"
End if 
C_OBJECT:C1216($obRec; $obSel)
C_COLLECTION:C1488($cTemp)
$cTemp:=New collection:C1472
ARRAY TEXT:C222(atTableNames; 0)
//STR_GetTableNameList(->atTableNames)
C_TEXT:C284($vtProperty)
var $tableNum : Integer
For each ($vtProperty; ds:C1482)
	If ($vtProperty#"zz@")
		$cTemp.push(New object:C1471("tableName"; $vtProperty; "tableNum"; ds:C1482[$vtProperty].getInfo().tableNumber))
	End if 
End for each 
Form:C1466[$lb_Name].ents:=$cTemp

var $cColumns : Collection

If (False:C215)
	If (LISTBOX Get number of columns:C831(*; $lb_Name)=0)
		LISTBOX INSERT COLUMN FORMULA:C970(*; $lb_Name; 1; "tableName"; "This.tableName"; Is text:K8:3; "headerTable1"; $NilPtr)
		OBJECT SET TITLE:C194(*; "headerTable1"; "TableName")
		LISTBOX SET COLUMN WIDTH:C833(*; "tableName"; 150)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "tableName"; Align left:K42:2)
		LISTBOX INSERT COLUMN FORMULA:C970(*; $lb_Name; 2; "tableNum"; "This.tableNum"; Is text:K8:3; "headerTable2"; $NilPtr)
		OBJECT SET TITLE:C194(*; "headerTable2"; "Num")
		LISTBOX SET COLUMN WIDTH:C833(*; "tableNum"; 40; 60)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "tableNum"; Align right:K42:4)
		
		var $width_i : Integer
		$width_i:=LISTBOX Get column width:C834(*; "tableNum")
		
	End if 
End if 