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

C_TEXT:C284(vtTableName)
If (vtTableName="")  // setup the fields, default is Customer
	vtTableName:="Customer"
End if 
C_COLLECTION:C1488($cTemp)
$cTemp:=New collection:C1472

C_TEXT:C284($vtProperty)
C_OBJECT:C1216($obProperty; $obClass)
$obClass:=ds:C1482[vtTableName]
For each ($vtProperty; $obClass)
	$obProperty:=$obClass[$vtProperty]
	$cTemp.push(New object:C1471("fieldName"; $obProperty.name; "fieldType"; $obProperty.type))
End for each 
$cTemp:=$cTemp.orderBy("fieldName")


Form:C1466.cFields:=$cTemp
If (LISTBOX Get number of columns:C831(*; "lbFields")=0)
	LISTBOX INSERT COLUMN FORMULA:C970(*; "lbFields"; 1; "Column_fieldName"; "This.fieldName"; Is text:K8:3; "header_Field1"; $NilPtr)
	OBJECT SET TITLE:C194(*; "Header_Field1"; "FieldNames")
	LISTBOX INSERT COLUMN FORMULA:C970(*; "lbFields"; 2; "Column_fieldType"; "This.fieldType"; Is text:K8:3; "header_Field2"; $NilPtr)
	OBJECT SET TITLE:C194(*; "header_Field2"; "FieldType")
	LISTBOX SET COLUMN WIDTH:C833(*; "Column_fieldType"; 50)
	LISTBOX INSERT COLUMN FORMULA:C970(*; "lbFields"; 3; "Column_fieldValue"; "This.fieldValue"; Is text:K8:3; "header_Field3"; $NilPtr)
	OBJECT SET TITLE:C194(*; "header_Field3"; "Value")
End if 
C_LONGINT:C283($inc; $cnt)
C_TEXT:C284($vtName)

