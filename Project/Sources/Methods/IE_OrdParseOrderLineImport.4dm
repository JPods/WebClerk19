//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:     IE_OrdParseOrderLineImport 
	//Desc.:  Parse passed text for [Order] import
	//NB:      
	//CB:      IE_OrdImportOrders
	//New:    04/14/2000.nds   
End if 

C_LONGINT:C283($1; $lIndice)
$lIndice:=$1

C_TEXT:C284($sItemNumber)  //[OrdLine]ItemNum
$sItemNumber:=IE_OrdFindFieldPtrInArray((->[OrderLine:49]itemNum:4); ->aptOrdLineFieldPointers; ->atOrdLineImport{$lIndice})->

QUERY:C277([Item:4]; [Item:4]itemNum:1=$sItemNumber)
EDI_OrdLnAdd
IE_OrdFillOrdLineArraysByPtrArr(->aptOrdLineFieldPointers; ->atOrdLineImport{$lIndice}; aoLineAction)
EDI_OrdLnExtd
UNLOAD RECORD:C212([Item:4])
//End of routine