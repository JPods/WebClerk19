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
If (Form:C1466.dataClassName=Null:C1517)
	Form:C1466.dataClassName:="Customer"
End if 
If (Form:C1466[$lb_Name]=Null:C1517)
	Form:C1466.LB_Tables:=cs:C1710.listboxK.new("LB_Tables")
	//This.name:=$name  //      the name of the listbox
	//This.source:=Null  //  collection/entity selection form.<>.data is drawn from
	//This.ents:=Null
	//This.sel:=Null
	//This.kind:=Null
	//This.edit:=Null
	//This.old:=Null
	//This.cur:=Null
	//This.pos:=0
	//This.entry_o:=Null
	//This.related:=Null
End if 
C_OBJECT:C1216($obRec; $obSel)
C_COLLECTION:C1488($cTemp)
$cTemp:=New collection:C1472
C_TEXT:C284($vtProperty)
var $tableNum : Integer
For each ($vtProperty; ds:C1482)
	If ($vtProperty#"zz@")  // remove any non-user tables 
		$cTemp.push(New object:C1471("tableName"; $vtProperty; "tableNum"; ds:C1482[$vtProperty].getInfo().tableNumber))
	End if 
End for each 
Form:C1466[$lb_Name].ents:=$cTemp
If (Form:C1466.dataClassName=Null:C1517)
	Form:C1466[$lb_Name].sel:=Form:C1466[$lb_Name].ents.query("tableName = :1"; "Customer")
Else 
	Form:C1466[$lb_Name].sel:=Form:C1466[$lb_Name].ents.query("tableName = :1"; Form:C1466.dataClassName)
End if 
Form:C1466[$lb_Name].cur:=Form:C1466[$lb_Name].sel[0]
Form:C1466.dataClassName:=Form:C1466.LB_Tables.cur.tableName
var $c : Collection
var $row : Integer
//$c:=Form[$lb_Name].ents.tableName.toCollection()
//$row:=Form[$lb_Name].ents.tableName.indexOf("Customer")
//$row:=Form[$lb_Name].ents.findIndex("tableName = :1"; "Customer")

$c:=Form:C1466[$lb_Name].ents.indices("tableName = :1"; "Customer")
$row:=$c[0]+1
$row:=19
OBJECT SET SCROLL POSITION:C906(*; $lb_Name; $row)
LISTBOX SELECT ROW:C912(*; $lb_Name; $row)
