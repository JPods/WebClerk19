//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/22/10, 15:34:45
// ----------------------------------------------------
// Method: xmlGetAttributes
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $2)

$elementListPtr:=$1
$attributeListPtr:=$2

xmlListNew($attributeListPtr)

If (Selected list items:C379($elementListPtr->)#0)
	GET LIST ITEM:C378($elementListPtr->; Selected list items:C379($elementListPtr->); $itemRef; $itemText)
	
	COPY ARRAY:C226(attribute2DArr{$itemRef}; attributeArray)
	
	xmlListArrayToList(->attributeArray; $attributeListPtr)
End if 