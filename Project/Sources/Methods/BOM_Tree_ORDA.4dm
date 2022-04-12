//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/05/20, 17:21:04
// ----------------------------------------------------
// Method: BOM_ORDA
// Description
// 
//  // This is an attempt to learn ORDA relative to BOM 
//  
// Parameters
// ----------------------------------------------------
//  called by
// Form.items:=BOM_Tree_ORDA(Form.itemsMultiSel;(ck_ShowTree=1))
C_COLLECTION:C1488($col; $col2)
C_OBJECT:C1216($obItems; $obItemsSel)

C_BOOLEAN:C305($fl_Complete)  // force for complier

$obItemsSel:=$1  // Selected items
$fl_Complete:=$2  // must be formlist item
//
$col:=New collection:C1472
$multiplier:=1
If ($obItemsSel.length>0)
	If ($fl_Complete)
		$level:=0
		$obItems:=$obItemsSel.first()  //First selected item
		// $item is not defined
		For each ($Items; $obItems.Items_List)
			$col:=BOM_Leaf_ORDA($Items; $col; $level; $multiplier)
		End for each 
	Else 
		$col:=$obItemsSel.first().Items_List.toCollection("")  //Collection of items
	End if 
End if 
//
$0:=$col