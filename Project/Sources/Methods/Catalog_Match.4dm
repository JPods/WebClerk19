//%attributes = {}

// Modified by: Bill James (2022-10-15T05:00:00Z)
// Method: Catalog_Match
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($dataRaw_c : Collection; $setup_o : Object)->$result : Collection


$recSuffix_s:=ds:C1482.Item.query("itemNum = :1"; "@copperfield@")


//$setup_o.path : Text; $setup_o.delimitDoc : Text; $setup_o.delimitLine : Text
If ($dataRaw_c#Null:C1517)
	// evaluate the catalog to existing data
	var itemOrig_s; itemOrig_o : Object
	itemOrig_s:=ds:C1482.Item.query("itemNum = :1"; "@-CCS")
	ConsoleLog("Original data for -CCS: "+String:C10(itemOrig_s.length))
	var itemNum_c : Collection
	itemNum_c:=itemOrig_s.itemNum
	ARRAY TEXT:C222(aItemsCurrent; 0)
	ARRAY TEXT:C222(aItemsFound; 0)
	ARRAY TEXT:C222(aItemsMustAdd; 0)
	COLLECTION TO ARRAY:C1562(itemNum_c; aItemsCurrent)
	
	
	var $myDoc : Time
	var $doc_t; $out_t : Text
	var $data_c; $raw_c : Collection
	$data_c:=New collection:C1472()
	
	var $itemNum_t : Text
	var $cntLines : Integer
	
	$out_t:=Catalog_lineOut($setup_o.line; "header")
	
	
	For each ($incoming_o; $dataRaw_c)
		$cntLines:=$cntLines+1
		line_o:=New object:C1471
		line_o:=Catalog_ItemUpdate($incoming_o; $setup_o)
		If (Macintosh option down:C545)
			
		End if 
		
		$out_t:=$out_t+Catalog_lineOut(line_o)
		$data_c.push(line_o)
		
		//$line_c:=Catalog_CSVParse($line_t)
	End for each 
	
	SET TEXT TO PASTEBOARD:C523($out_t)
	
	$result:=$data_c
	
Else 
	$result:=New collection:C1472
	$result.push("error: No setup_o defined")
End if 