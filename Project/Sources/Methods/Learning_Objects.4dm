//%attributes = {}
//  ORDA Objects very good
//  https://www.youtube.com/watch?v=EigVFWEcgZw&t=525s
#DECLARE($voInput : Object)->$viResult : Integer
C_LONGINT:C283($viResult)

ARRAY TEXT:C222($arr_property; 0)
ARRAY LONGINT:C221($arr_type; 0)

If (Count parameters:C259=1)
	
	$ob:=$voInput
	
	OB GET PROPERTY NAMES:C1232($ob; $arr_property; $arr_type)
	$viResult:=Size of array:C274($arr_property)
	
End if 

//  https://kb.4d.com/assetid=78227
// Name: OB_GetValues
// Description: Method will return a collection of values from target object
// The order of collection will match the order of array from OB GET PROPERTY NAMES
// Parameter:
// $1 (Object) - target object
//
// Return
// $0(Collection)- a collection of values

// 4D has a built-in commend, OB GET PROPERTY NAMES, to retrieve all property names of an object in text array. 
// However, it does not have a similar command to get property values. 
// For each that targets to iterate through collections, entity selections and objects. 
//This provides developer easy access to every property name and value of objects. 
// Below is a method, OB_GetValues, utilizing this new forEach iteration to retrieve a 
//collection of values of all properties of the object:

// for names:  OB GET PROPERTY NAMES


C_OBJECT:C1216($voInput)
C_COLLECTION:C1488($vcOutPut)
C_TEXT:C284($property)
$vcOutPut:=New collection:C1472
For each ($property; $voInput)
	$vcOutPut.push($voInput[$property])
End for each 




