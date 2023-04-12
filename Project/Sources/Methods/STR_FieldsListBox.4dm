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
var $obClass : Object

$obClass:=ds:C1482[tableName]

For each ($vtProperty; $obClass)
	$obProperty:=$obClass[$vtProperty]
	$cTemp.push(New object:C1471("fieldName"; $obProperty.name; "type"; $obProperty.type; "fieldType"; $obProperty.fieldType; "fieldNumber"; $obProperty.fieldNumber))
End for each 
$cTemp:=$cTemp.orderBy("fieldName")

Form:C1466[$listboxName].ents:=$cTemp
Form:C1466[$listboxName].cur:=Null:C1517
Form:C1466[$listboxName].sel:=Null:C1517

