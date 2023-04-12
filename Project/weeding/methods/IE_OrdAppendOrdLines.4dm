//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  IE_OrdAppendOrdLines 
	//Desc.:  Retrieves OrdLines from import arrays and adds to current Order
	//NB:      
	//CB:      
	//New:    04/18/2000.nds   
End if 

C_LONGINT:C283($1; $lOrderNumber)
$lOrderNumber:=$1

C_LONGINT:C283($i; $lSize)
$lSize:=Size of array:C274(atOrdLineImport)

C_LONGINT:C283($lOrdLine_OrderNum)
For ($i; 1; $lSize)
	
	$lOrdLine_OrderNum:=IE_OrdFindFieldPtrInArray((->[OrderLine:49]orderNum:1); ->aptOrdLineFieldPointers; ->atOrdLineImport{$i})->
	If ($lOrdLine_OrderNum=$lOrderNumber)
		IE_OrdParseOrderLineImport($i)
	End if 
	
End for 

//End of routine