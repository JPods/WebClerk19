//%attributes = {}

// Modified by: Bill James (2022-07-22T05:00:00Z)
// Method: LBX_ColumnSet
// Description Keep this so list boxes can be managed outside of the listboxk class
// Needed this for import collection and other non table collections. Might have been able
// to have it as part of the class, but ran out of time.
// Parameters
// ----------------------------------------------------
#DECLARE($listboxName : Text; $position : Integer; $column_o : Object)
ON ERR CALL:C155("OEC_ConsoleDebug")
var $field_t : Text
$field_t:=Replace string:C233($column_o.dataSource; "This."; "")
If ($column_o.header.text="")
	$column_o.header.text:=$field_t
	If ($doCaps)
		$column_o.header.text:=Uppercase:C13($field_t[[1]])+Substring:C12($field_t; 2)
	End if 
End if 
If ($column_o.fieldType=Null:C1517)
	$column_o.fieldType:=ds:C1482[Form:C1466.dataClassName][$field_t].fieldType
End if 
LISTBOX INSERT COLUMN FORMULA:C970(*; $listboxName; $position; \
$column_o.name; $column_o.dataSource; $column_o.fieldType; \
$column_o.header.name; $nullpointer; $column_o.footer.name; $nullpointer)
OBJECT SET TITLE:C194(*; $column_o.header.name; $column_o.header.text)


If ($column_o.enterable=Null:C1517)
	OBJECT SET ENTERABLE:C238(*; $column_o.name; False:C215)
End if 

If ($column_o.turncate=Null:C1517)
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk truncate:K53:37; lk without ellipsis:K53:64)
Else 
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk truncate:K53:37; $column_o.turncate)
End if 
//  lk without ellipsis = , lk with ellipsis = 



If ($column_o.width=Null:C1517)
	LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; 100)
Else 
	LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; $column_o.width)
End if 

If ($column_o.format#Null:C1517)
	
	OBJECT SET FORMAT:C236(*; $column_o.name; $column_o.format)
	//$column_o.format:=OBJECT Get format(*; $column_o.name)  // 1
End if 


If ($column_o.align#Null:C1517)
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $column_o.name; $column_o.align)
	//$column_o.align:=OBJECT Get horizontal alignment(*; $column_o.name)
End if 

If ($column_o.wordWrap#Null:C1517)  // boolean
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk allow wordwrap:K53:39; $column_o.wordWrap)
	// $column_o.wordWrap:=LISTBOX Get property(*; $column_o.name; lk allow wordwrap)
End if 

If ($column_o.bgColor#Null:C1517)
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk background color expression:K53:47; $column_o.bgColor)
	// $column_o.bgColor:=LISTBOX Get property(*; $column_o.name; lk background color expression)
End if 

If ($column_o.fontColor#Null:C1517)
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk font color expression:K53:48; $column_o.fontColor)
	//$column_o.fontColor:=LISTBOX Get property(*; $column_o.name; lk font color expression)
End if 

If ($column_o.widthMin#Null:C1517)  // integer
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column min width:K53:50; $column_o.widthMin)
	// $column_o.widthMin:=LISTBOX Get property(*; $column_o.name; lk column min width)
End if 

If ($column_o.widthMax#Null:C1517)  // integer
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column max width:K53:51; $column_o.widthMax)
	//$column_o.widthMax:=LISTBOX Get property(*; $column_o.name; lk column max width)
End if 

If ($column_o.resizable#Null:C1517)  // boolean
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column resizable:K53:40; $column_o.resizable)
	// $column_o.resizable:=LISTBOX Get property(*; $column_o.name; lk column resizable)
End if 

If ($column_o.displayType#Null:C1517)
	LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk display type:K53:46; $column_o.displayType)
	//  lk numeric format
	//  
	//  Display Type property for numeric columns
	//  $column_o.displayType:=LISTBOX Get property(*; $column_o.name; lk display type)
End if 



If ($column_o.doubleClick#Null:C1517)  // integer
	//LISTBOX SET PROPERTY(*; $column_o.name; lk double click on row; lk do nothing ||  lk edit record  || lk display record)
	// $column_o.resizable:=LISTBOX Get property(*; $column_o.name; lk double click on row)
	// LISTBOX SET PROPERTY(*; $column_o.name; lk detail form name; vFormName_t)
End if 


ON ERR CALL:C155("")