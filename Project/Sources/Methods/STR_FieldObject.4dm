//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/03/21, 10:14:20
// ----------------------------------------------------
// Method: STR_FieldObject
// Description
// 
//
// Parameters
// ----------------------------------------------------


// STR_GetTableNameCollection
C_COLLECTION:C1488($0; $cTemp)
$cTemp:=New collection:C1472
C_TEXT:C284($1; $vtProperty)
C_OBJECT:C1216($obClass)
If (Count parameters:C259=1)
	$vtProperty:=$1
Else 
	$vtProperty:="Customer"
End if 
vtTableName:=$vtProperty
$obClass:=ds:C1482[$vtProperty]
For each ($vtProperty; $obClass)
	$obProperty:=$obClass[$vtProperty]
	$cTemp.push(New object:C1471("fieldName"; $obProperty.name; "fieldType"; $obProperty.type))
End for each 
$0:=$cTemp