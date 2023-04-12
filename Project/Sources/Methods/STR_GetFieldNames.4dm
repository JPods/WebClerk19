//%attributes = {}

// Modified by: Bill James (2022-08-02T05:00:00Z)
// Method: STR_GetFieldNames
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text)->$fieldNames : Text
var $class_o : Object
$class_o:=ds:C1482[$tableName]
If ($class_o=Null:C1517)
	$fieldNames:="Error: invalid tableName: "+$tableName
Else 
	var $property : Text
	var $properties_c; $fieldNames_c : Collection
	
	//$tableName:=$class_o.getInfo().name
	//$properties_c:=$class_o.getDataClass("fieldName")
	//$properties_c:=$class_o.getDataClass("name")
	var $c : Collection
	$c:=New collection:C1472
	For each ($property; $class_o)
		$c.push($class_o[$property].name)
	End for each 
	$c:=$c.orderBy()
	$fieldNames:=$c.join(";")
End if 