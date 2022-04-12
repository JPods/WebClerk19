//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/05/20, 17:35:35
// ----------------------------------------------------
// Method: BOM_Leaf_ORDA
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obItem; $obItem2; $element)
C_COLLECTION:C1488($col)

$obItem:=$1  // Item entity
$col:=$2  // collection to display
$level:=$3
$multiplier:=$4

$col2:=New collection:C1472

$element:=$obItem.toObject("")
$col.push($element)  // Adds the current item to the collection
$element.level:=$level  // Adds some properties to this element
$element.totalQty:=$obItem.Quantity*$multiplier  // expand by BOM
$multiplier:=$multiplier*$element.Quantity  // increment the multiplier
$level:=$level+1  // increment the level
If ($obItem.BOM#Null:C1517)  // the item has related BOM
	For each ($obItem2; $obItem.BOM.List)  // name of the relationship.
		$col:=BOM_Leaf_ORDA($obItem2; $col; $level; $multiplier)
	End for each 
End if 

$0:=$col
