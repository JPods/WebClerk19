var $data_c : Collection
var $setup_o; $line_o : Object
var $path_t; $script : Text
$line_o:=New object:C1471("foundItem"; -3; \
"foundByVP"; -3; \
"foundMfrByID"; -3; \
"foundVenByID"; -3; \
"foundMfrByVP"; -3; \
"foundVenByVP"; -3; \
"itemNum"; ""; \
"descriptionOld"; ""; \
"descriptionChanged"; -3; \
"costNew"; -3; \
"costOld"; -3; \
"costAvg"; -3; \
"costLast"; -3; \
"%change"; 0; \
"$change"; 0)
var $tm_s; $tm_e : Object
$tm_s:=ds:C1482.TallyMaster.query("name = :1 AND purpose = :2 AND status = :3"; \
"Copperfield"; "CostUpdate"; "active")
If ($tm_s.length>0)
	$script:=$tm_s.first().script
End if 


var itemOrig_s; itemOrig_o : Object
itemOrig_s:=ds:C1482.Item.query("itemNum = :1"; "@-CCS")
ConsoleLog("Original data for -CCS: "+String:C10(itemOrig_s.length))
var itemNum_c : Collection
itemNum_c:=itemOrig_s.itemNum
ARRAY TEXT:C222(aItemsCurrent; 0)
ARRAY TEXT:C222(aItemsFound; 0)
ARRAY TEXT:C222(aItemsMustAdd; 0)
COLLECTION TO ARRAY:C1562(itemNum_c; aItemsCurrent)


$path_t:="/Users/williamjames/Downloads/Copperfield/TabText.txt"
$path_t:=Convert path POSIX to system:C1107($path_t)
$setup_o:=New object:C1471("path"; $path_t; \
"delimitDoc"; "\r"; \
"delimitLine"; "\t"; \
"vendorSuffix"; "-CCS"; \
"line_o"; $line_o; \
"script"; $script)
$data_c:=Catalog_LoadCSV($setup_o)

var $out_t; $name; $lineOut_t : Text
var $line_o : Object
var $cnt : Integer
var $value : Variant
$cnt:=0
If ($data_c.length>0)
	$line_o:=$data_c[1]
	$out_t:="foundItem\tfoundByVP\tfoundMfrByID\tfoundVenByID\t"+\
		"foundMfrByVP\tfoundVenByVP\titemNum\tdescriptionOld\t"+\
		"descriptionChanged\tcostNew\tcostOld\tcostAvg\tcostLast\t%change\t$change"+\
		"Inventory ID\tDescription\tPosting Class\tNew Price\tVendor Part\r"
	//For each ($name; $line_o)
	//$line_o[$name]
	
	
	//End for each 
	
	For each ($line_o; $data_c)
		$lineOut_t:=""
		For each ($name; $line_o)
			$lineOut_t:=String:C10($line_o[$name])+"\t"
		End for each 
		$lineOut_t:=Substring:C12($lineOut_t; 1; Length:C16($lineOut_t)-1)
	End for each 
	$out_t:=$out_t+$lineOut_t+"\r"
End if 
SET TEXT TO PASTEBOARD:C523($out_t)