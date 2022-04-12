//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/18/10, 15:58:42
// ----------------------------------------------------
// Method: xmlParseSource
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

$rootElementRef:=$1

//assign form objects to local pointers ---------------------
$elementListPtr:=->hList1
$attributeListPtr:=->hList2

//create an empty list to display the elements ---------------
xmlListNew($elementListPtr)

If (OK=1)
	xmlParseTree($rootElementRef; $elementListPtr->)
	DOM CLOSE XML:C722($rootElementRef)
End if 

//select the first item in the element list, and load its attributes --
SELECT LIST ITEMS BY POSITION:C381($elementListPtr->; 1)
xmlGetAttributes($elementListPtr; $attributeListPtr)