//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-12-27T06:00:00Z)
// Method: import_TiCollection
//  https://products.aspose.app/cells/conversion/excel-to-json
// Description 
// Parameters
// ----------------------------------------------------

READ WRITE:C146([Item:4])

var $path; $working : Text
If ($path="")
	$path:="/Users/williamjames/Documents/CommerceExpert/act/2022/Copperfield_Data_2022-12/Copperfield_json_2022-12-31.json"
End if 

var doc_c; $title_c : Collection
doc_c:=New collection:C1472

var $titles_t; $one_t : Text
$titles_t:="itemNum;Inventory_ID;Description;Product_Type;Price;"+\
"Vendor_Inventory_ID;Previous_Part_#;Product_Group;Size_Group;Alerts;"+\
"Special_Order;Long_Description;FL_freightline;;ThumbNailPic;FullImagePath;"+\
"Brochure_Link;MSDS;Install_Manual_Link;Video_Link;Weight"
$title_c:=Split string:C1554($titles_t; "\t")

//$sel_o:=ds.Item.query("dateLastCost == :1"; Current date)
//$sel_o.drop()

$working:=Document to text:C1236(Convert path POSIX to system:C1107($path))
If (error=0)
	var $data_o : Object
	$data_o:=JSON Parse:C1218($working)
	var $page1_c : Collection
	$page1_c:=New collection:C1472
	$page1_c:=$data_o.data
	For each ($line_o; $page1_c)
		
		$sel_o:=ds:C1482.Item.query("itemNum == :1"; $line_o.itemNum)
		If ($sel_o.length>0)
			ConsoleLog("Count:"+String:C10($sel_o.length)+": itemNum: "+$line_o.itemNum)
			$result:=$sel_o.drop()
		End if 
		
		For each ($one_t; $title_c)
			If ($line_o[$one_t]=Null:C1517)
				$line_o[$one_t]:=""
			End if 
		End for each 
		
		//If ($line_o.Inventory_ID=Null)
		//$line_o.Inventory_ID:=""
		//End if 
		//If ($line_o.Description=Null)
		//$line_o.Description:=""
		//End if 
		//If ($line_o.Product_Type=Null)
		//$line_o.Product_Type:=""
		//End if 
		//If ($line_o.Product_Group=Null)
		//$line_o.Product_Group:=""
		//End if 
		//If ($line_o.Size_Group=Null)
		//$line_o.Size_Group:=""
		//End if 
		//If ($line_o.SpecialOrder=Null)
		//$line_o.SpecialOrder:=""
		//End if 
		//If ($line_o.Price=Null)
		//$line_o.Price:=0
		//End if 
		//If ($line_o.Vendor_Inventory_ID=Null)
		//$line_o.Vendor_Inventory_ID:=""
		//End if 
		//If ($line_o.previous=Null)
		//$line_o.previous:=""
		//End if 
		//If ($line_o.Alerts=Null)
		//$line_o.Alerts:=""
		//End if 
		//If ($line_o.ThumbNailPic=Null)
		//$line_o.ThumbNailPic:=""
		//End if 
		//If ($line_o.FullImagePath=Null)
		//$line_o.FullImagePath:=""
		//End if 
		//If ($line_o.Brochure_Link=Null)
		//$line_o.Brochure_Link:=""
		//End if 
		//If ($line_o.MSDS=Null)
		//$line_o.MSDS:=""
		//End if 
		//If ($line_o.Install_Manual_Link=Null)
		//$line_o.Install_Manual_Link:=""
		//End if 
		//If ($line_o.Video_Link=Null)
		//$line_o.Video_Link:=""
		//End if 
		$doRecords:=True:C214  //aready done
		If ($doRecords)
			$rec_o:=ds:C1482.Item.new()
			$rec_o.itemNum:=$line_o.itemNum
			$rec_o.save()
			$rec_o.reload()
			$rec_o.obGeneral:=Init_obGeneral
			$rec_o.obGeneral.history:=New collection:C1472
			$rec_o.obGeneral.history.push(New object:C1471("date"; Current date:C33; "raw"; $line_o))
			
			$rec_o.vendorItemNum:=$line_o.Inventory_ID
			$rec_o.vendorID:="Copperfield"
			$rec_o.description:=$line_o.Description
			$rec_o.obGeneral.productType:=$line_o.Product_Type
			$rec_o.obGeneral.productGroup:=$line_o.Product_Group
			$rec_o.obGeneral.sizeGroup:=$line_o.Size_Group
			$rec_o.obGeneral.specialOrder:=$line_o.SpecialOrder
			
			$rec_o.costMSC:=Num:C11($line_o.Price)
			$rec_o.costAverage:=$rec_o.costMSC
			$rec_o.costLastInShip:=$rec_o.costMSC
			
			$rec_o.priceA:=$line_o.costMSC*2
			$rec_o.priceB:=$line_o.costMSC*2
			$rec_o.priceC:=$line_o.costMSC*2
			$rec_o.priceD:=$line_o.costMSC*2
			
			$rec_o.mfrItemNum:=$line_o.Vendor_Inventory_ID
			$rec_o.obGeneral.itemNumPrevious:=$line_o.previous
			$rec_o.alertMessage:=$line_o.Alerts
			//$rec_o.descriptionDetail:=$line_o.Long_Description
			$rec_o.obGeneral.docs:=New object:C1471("pathTN"; $line_o.ThumbNailPic; \
				"path"; $line_o.FullImagePath; \
				"brochure"; $line_o.Brochure_Link; \
				"MSDS"; $line_o.MSDS; \
				"install"; $line_o.Install_Manual_Link; \
				"video"; $line_o.Video_Link)
			
			// need$rec_o.pathTN
			$rec_o.path:=$line_o.FullImagePath
			$rec_o.weightAverage:=$line_o.Weight
			$rec_o.dateLastCost:=Current date:C33
			$rec_o.dtLastSync:=$viDTSync.dt90
			var $keyTag_t : Text
			$keyTag_t:=KeyTagsFromAlphaFields($rec_o; "Item"; False:C215)
			var $result : Object
			$result:=$rec_o.save()
		End if 
		doc_c.push($line_o)
	End for each 
End if 


Form:C1466.data:=doc_c
LISTBOX DELETE COLUMN:C830(*; "LB_Import"; 1; \
LISTBOX Get number of columns:C831(*; "LB_Import"))
var $fields_c; $columns_c : Collection
$columns_c:=New collection:C1472
var $field : Text
var $postion : Integer
$postion:=0
$fields_c:=Split string:C1554($titles_t; ";")
var $column_o : Object
$column_o:=New object:C1471
For each ($field; $fields_c)
	var $type : Integer
	$type:=Value type:C1509($field)
	
	$postion:=$postion+1
	$column_o:=LBX_ColumnImportName($field)
	//$column_o:=LB_Import._setColumnNameImport($field; $postion; $type)
	LBX_ColumnSet("LB_Import"; $postion; $column_o)
	//LB_Import._setColumnConstruct($postion; $column_o)
End for each 


LB_Import.setSource(Form:C1466.data)





If (False:C215)
	
	var doc_c; $lines_c; $title_c; $cells_c : Collection
	var $line_t; $titles_t; $titleOne_t : Text
	doc_c:=New collection:C1472
	$lines_c:=Split string:C1554($working; "\r")
	$titles_t:=$lines_c[0]
	$title_c:=Split string:C1554($titles_t; "\t")
	$titles_t:=$title_c.join(";")
	
	$lines_c.remove(0)
	
	var $viDTSync : cs:C1710.cDateTime  // define a DT for records in this import
	$viDTSync:=cs:C1710.cDateTime.new(Current date:C33; ?00:00:05?)
	
	If (False:C215)
		$doc_c:=New collection:C1472
		var $inc : Integer
		For each ($line_t; $lines_c)
			$cells_c:=Split string:C1554($line_t; "\t")
			$line_o:=New object:C1471
			$inc:=0
			For each ($value; $cells_c)
				If ($inc+1<=$title_c.length)
					$line_o[$title_c[$inc]]:=$value
				End if 
				$inc:=$inc+1
			End for each 
			
			If (False:C215)
				var $rec_o; $sel_o : Object
				$sel_o:=ds:C1482.Item.query("itemNum == :1"; $line_o.itemNum)
				Case of 
					: ($sel_o.length>1)
						ConsoleLog("Count:"+String:C10($sel_o.length)+": itemNum: "+$line_o.itemNum)
						$result:=$sel_o.drop()
					: ($sel_o.length=1)
						ConsoleLog("Count:"+String:C10($sel_o.length)+": itemNum: "+$line_o.itemNum)
						$result:=$sel_o.drop()
				End case 
				//QUERY([Item]; [Item]itemNum=$line_o.itemNum)
				//If (Records in selection([Item])>0)
				//DELETE SELECTION([Item])
				//End if 
				//REDUCE SELECTION([Item]; 0)
				
				//$rec_o:=ds.Item.query("itemNum = $1"; $line_o.itemNum).first()
				$rec_o:=ds:C1482.Item.new()
				$rec_o.itemNum:=$line_o.itemNum
				$rec_o.save()
				$rec_o.reload()
				$rec_o.obGeneral:=Init_obGeneral
				$rec_o.obGeneral.history:=New collection:C1472
				$rec_o.obGeneral.history.push(New object:C1471("date"; Current date:C33; "raw"; $line_o))
				
				$rec_o.vendorItemNum:=$line_o.Inventory_ID
				$rec_o.vendorID:="Copperfield"
				$rec_o.description:=$line_o.Description
				$rec_o.obGeneral.productType:=$line_o.Product_Type
				$rec_o.obGeneral.productGroup:=$line_o.Product_Group
				$rec_o.obGeneral.sizeGroup:=$line_o.Size_Group
				$rec_o.obGeneral.specialOrder:=$line_o.SpecialOrder
				
				$rec_o.costMSC:=Num:C11($line_o.Price)
				$rec_o.costAverage:=$rec_o.costMSC
				$rec_o.costLastInShip:=$rec_o.costMSC
				
				$rec_o.priceA:=$line_o.costMSC*2
				$rec_o.priceB:=$line_o.costMSC*2
				$rec_o.priceC:=$line_o.costMSC*2
				$rec_o.priceD:=$line_o.costMSC*2
				
				$rec_o.mfrItemNum:=$line_o.Vendor_Inventory_ID
				$rec_o.obGeneral.itemNumPrevious:=$line_o.obGeneral.previous
				$rec_o.alertMessage:=$line_o.Alerts
				//$rec_o.descriptionDetail:=$line_o.Long_Description
				$rec_o.obGeneral.docs:=New object:C1471("pathTN"; $line_o.ThumbNailPic; \
					"path"; $line_o.FullImagePath; \
					"brochure"; $line_o.Brochure_Link; \
					"MSDS"; $line_o.MSDS; \
					"install"; $line_o.Install_Manual_Link; \
					"video"; $line_o.Video_Link)
				
				// need$rec_o.pathTN
				$rec_o.path:=$line_o.FullImagePath
				$rec_o.weightAverage:=$line_o.Weight
				$rec_o.dateLastCost:=Current date:C33
				$rec_o.dtLastSync:=$viDTSync.dt90
				var $keyTag_t : Text
				$keyTag_t:=KeyTagsFromAlphaFields($rec_o; "Item"; False:C215)
				var $result : Object
				$result:=$rec_o.save()
			End if 
			doc_c.push($line_o)
		End for each 
		
	End if 
	
	
End if 
