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

C_OBJECT:C1216($obRec; $obSel)
C_COLLECTION:C1488($cTemp)
ARRAY TEXT:C222(atTableNames; 0)
STR_GetTableNameList(->atTableNames)
$cTemp:=New collection:C1472
ARRAY TO COLLECTION:C1563($cTemp; atTableNames; "tableName")
Form:C1466.cTables:=$cTemp
If (LISTBOX Get number of columns:C831(*; "lbTables")=0)
	LISTBOX INSERT COLUMN FORMULA:C970(*; "lbTables"; 1; "tableName"; "This.tableName"; Is text:K8:3; "headerTable1"; $NilPtr)
	OBJECT SET TITLE:C194(*; "headerTable1"; "TableName")
End if 