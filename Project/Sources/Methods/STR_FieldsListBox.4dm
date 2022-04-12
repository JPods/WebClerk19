//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/01/21, 06:09:53
// ----------------------------------------------------
// Method: STR_FieldsListBox
// Description
//
//
// Parameters
// ----------------------------------------------------
#DECLARE($listboxName : Text; $tableName : Text)
var tableName : Text
If ($listboxName="")
	$listboxName:="LB_Fields"
End if 
If ($tableName="")  // setup the fields, default is Customer
	tableName:="Customer"
Else 
	tableName:=$tableName
End if 
var $cTemp : Collection
$cTemp:=New collection:C1472

var $vtProperty : Text
var $obClass; $obProperty : Object
$obClass:=ds:C1482[tableName]
For each ($vtProperty; $obClass)
	$obProperty:=$obClass[$vtProperty]
	$cTemp.push(New object:C1471("fieldName"; $obProperty.name; "type"; $obProperty.type; "fieldType"; $obProperty.fieldType; "fieldNumber"; $obProperty.fieldNumber))
End for each 
$cTemp:=$cTemp.orderBy("fieldName")

Form:C1466[$listboxName].ents:=$cTemp

If (False:C215)
	Form:C1466.cFields:=$cTemp
	If (LISTBOX Get number of columns:C831(*; $listboxName)=0)
		LISTBOX INSERT COLUMN FORMULA:C970(*; $listboxName; 1; "Column_fieldName"; "This.fieldName"; Is text:K8:3; "Header_fieldName"; $NilPtr)
		OBJECT SET TITLE:C194(*; "Header_fieldName"; "FieldNames")
		LISTBOX INSERT COLUMN FORMULA:C970(*; $listboxName; 2; "Column_fieldType"; "This.fieldType"; Is text:K8:3; "header_fieldType"; $NilPtr)
		OBJECT SET TITLE:C194(*; "header_fieldType"; "FieldType")
		LISTBOX SET COLUMN WIDTH:C833(*; "Column_fieldType"; 50)
		LISTBOX INSERT COLUMN FORMULA:C970(*; $listboxName; 3; "Column_fieldNum"; "This.fieldNum"; Is text:K8:3; "header__fieldNum"; $NilPtr)
		OBJECT SET TITLE:C194(*; "header__fieldNum"; "Num")
		LISTBOX SET COLUMN WIDTH:C833(*; "Column_fieldNum"; 50)
	End if 
	var $cnt; $inc : Integer
	var $vtName : Text
End if 
