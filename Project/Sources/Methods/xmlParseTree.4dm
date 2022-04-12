//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/18/10, 16:02:12
// ----------------------------------------------------
// Method: xmlParseTree
// Description
// 
//
// Parameters
// ----------------------------------------------------

// XMLParse ($elementRef; $parentListRef)

//elementRef: XML element reference

C_TEXT:C284($elementName; $elementValue)
C_TEXT:C284($attributeName; $attributeValue)

C_LONGINT:C283($3; $4; $parentListRef; $childListRef)

$elementRef:=$1
$parentListRef:=$2

//get element info ---------------------------------------------
DOM GET XML ELEMENT NAME:C730($elementRef; $elementName)
DOM GET XML ELEMENT VALUE:C731($elementRef; $elementValue)
$elementID:=0

//format the element value
If ($elementValue="")
	$itemText:=$elementName
Else 
	$itemText:=$elementName+": "+$elementValue
End if 

//get attribute info ---------------------------------------------
$numAttributes:=DOM Count XML attributes:C727($1)

If ($numAttributes#0)
	$sizeOfArray:=Size of array:C274(attribute2DArr)+1  //make room for the new attributes
	INSERT IN ARRAY:C227(attribute2DArr; $sizeOfArray)
	
	$elementID:=$sizeOfArray  //assign the position so we can find it later
	
	For ($i; 1; $numAttributes)
		DOM GET XML ATTRIBUTE BY INDEX:C729($1; $i; $attributeName; $attributeValue)
		attributeTxt:=$attributeName+": "+$attributeValue
		APPEND TO ARRAY:C911(attribute2DArr; attributeTxt)
	End for 
End if 

//walk the tree recursively ------------------------------------
$elementRef:=DOM Get first child XML element:C723($elementRef)

$childListRef:=0

If (OK=1)  //a child exists
	$childListRef:=New list:C375
	While (OK=1)
		xmlParseTree($elementRef; $childListRef)
		$elementRef:=DOM Get next sibling XML element:C724($elementRef)
	End while 
End if 

//update the list ---------------------------------------------
APPEND TO LIST:C376($parentListRef; $itemText; $elementID; $childListRef; True:C214)