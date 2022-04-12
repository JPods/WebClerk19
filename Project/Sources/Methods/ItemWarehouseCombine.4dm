//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/30/12, 14:16:03
// ----------------------------------------------------
// Method: ItemWarehouseCombine
// Description
// 
//
// Parameters
// ----------------------------------------------------
$k:=Count parameters:C259
If ($k=1)
	$setDirection:=$1
Else 
	$setDirection:=0
End if 
If ($setDirection=1)
	TextToArray([ItemWarehouse:117]LocationID:4; ->aText1; "-")
	$k:=Size of array:C274(aText1)
	If ($k>0)
		[ItemWarehouse:117]Warehouse:3:=aText1{1}
		If ($k>1)
			[ItemWarehouse:117]Aisle:16:=aText1{2}
			If ($k>2)
				[ItemWarehouse:117]Column:17:=aText1{3}
				If ($k>3)
					[ItemWarehouse:117]Shelf:18:=aText1{4}
					If ($k>4)
						[ItemWarehouse:117]Bin:19:=aText1{5}
					End if 
				End if 
			End if 
		End if 
	End if 
Else 
	C_TEXT:C284($buildID; $placeholder)
	$buildID:=""
	$placeholder:="_"
	If ([ItemWarehouse:117]Warehouse:3="")
		$buildID:=$placeholder
	Else 
		$buildID:=[ItemWarehouse:117]Warehouse:3
	End if 
	$buildID:=$buildID+"-"
	
	If ([ItemWarehouse:117]Aisle:16="")
		$buildID:=$placeholder
	Else 
		$buildID:=$buildID+[ItemWarehouse:117]Aisle:16
	End if 
	$buildID:=$buildID+"-"
	
	
	If ([ItemWarehouse:117]Column:17="")
		$buildID:=$placeholder
	Else 
		$buildID:=$buildID+[ItemWarehouse:117]Column:17
	End if 
	$buildID:=$buildID+"-"
	
	
	If ([ItemWarehouse:117]Shelf:18="")
		$buildID:=$placeholder
	Else 
		$buildID:=$buildID+[ItemWarehouse:117]Shelf:18
	End if 
	
	
	
	If ([ItemWarehouse:117]Bin:19="")
		//
	Else 
		$buildID:=$buildID+"-"
		$buildID:=$buildID+[ItemWarehouse:117]Bin:19
	End if 
	
	[ItemWarehouse:117]LocationID:4:=$buildID
	
End if 