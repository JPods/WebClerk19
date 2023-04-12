
var $data_c : Collection
var $setup_o : Object
var $path_t : Text

$path_t:="/Users/williamjames/Downloads/VendorWishSheet_2023-02-13.txt"
$setup_o:=New object:C1471("path"; $path_t; \
"delimitLines"; "\r"; \
"delimitFields"; "\t"; \
"vendorSuffix"; "-CCS")
// Query([Item];[Item]ItemNum="@-CCS")

If (False:C215)
	var $cf_rec; $cf_o : Object
	$cf_o:=ds:C1482.Item.query("itemNum = @-CCS")
	For each ($cf_rec; $cf_o)
		$cf_rec.obGeneral:=JSON Parse:C1218($cf_rec.menu)
		$cf_rec.save()
	End for each 
	
	
	$cf_o.drop()
	$cf_o:=ds:C1482.Item.query("vendorID = copper@")
	$cf_o.drop()
	$cf_o:=New object:C1471
End if 

// query([item];[item]itemnum="@-CCS")


var $rec_o : Object
$dataRaw_c:=Catalog_Load($setup_o)

var $tm_o : Object
$tm_o:=ds:C1482.TallyMaster.query("name = :1 and purpose = :2"; "copperfieldMinimum"; "catalog").first()

If ($tm_o=Null:C1517)
	
	
	
End if 

$setup_o:=New object:C1471("dataClassName"; "Item"; \
"vendorSuffix"; "-CCS"; \
"dateTimeISO"; DateTime("ISO"); \
"tm"; $tm_o; \
"map"; New object:C1471(\
"mfr"; New object:C1471("home"; "mfrID"; "foreign"; "Manufacturer"); \
"key"; New object:C1471("home"; "itemNum"; "foreign"; "Inventory ID"); \
"discription"; New object:C1471("home"; "description"; "foreign"; "Description"); \
"priceA"; New object:C1471("home"; "priceA"; "foreign"; "priceA"); \
"profile"; New object:C1471("home"; "profile1"; "foreign"; "Product Type"); \
"mfrKey"; New object:C1471("home"; "mfrItemNum"; "foreign"; "Vendor Inventory ID"); \
"factor"; New object:C1471("home"; "script_Copperfield"; "foreign"; "Factor"); \
"costMSC"; New object:C1471("home"; "costMSC"; "foreign"; "Price"); \
"priceMSR"; New object:C1471("home"; "priceMSR"; "foreign"; "MSRP"); \
"status"; New object:C1471("home"; "status"; "foreign"; "Status"); \
"statusResolve"; New object:C1471("home"; "script_Copperfield"; "foreign"; ""); \
"mfrItemNum"; New object:C1471("home"; "mfrItemNum"; "foreign"; "Vendor Inventory ID"); \
"otherItemNum"; New object:C1471("home"; "script_Copperfield"; "foreign"; "Previous Part#"); \
"class"; New object:C1471("home"; "class"; "foreign"; "Product Group"); \
"alertMessagePO"; New object:C1471("home"; "alertMessagePO"; "foreign"; "Alerts"); \
"profile3"; New object:C1471("home"; "profile3"; "foreign"; "Special Order"); \
"profile5"; New object:C1471("home"; "profile5"; "foreign"; "freightline"); \
"descriptionDetail"; New object:C1471("home"; "descriptionDetail"; "foreign"; "Long Description"); \
"pathImageTn"; New object:C1471("home"; "imagePathTn"; "foreign"; "Thumb Nail Pic"); \
"pathImage"; New object:C1471("home"; "imagePath"; "foreign"; "Full Image Path"); \
"docPathBrochure"; New object:C1471("home"; "pathBrochure"; "foreign"; "Thumb Nail Pic"); \
"docPathMSDS"; New object:C1471("home"; "pathMSDS"; "foreign"; "Thumb Nail Pic"); \
"docPathManual"; New object:C1471("home"; "pathManual"; "foreign"; "Install Manual Link"); \
"docPathManualUser"; New object:C1471("home"; "pathManualUser"; "foreign"; "User Manual Link"); \
"docPathMSDS"; New object:C1471("home"; "pathMSDS"; "foreign"; "MSDS"); \
"docPathVideo"; New object:C1471("home"; "pathVideo"; "foreign"; "Video Link"); \
"weightBulk"; New object:C1471("home"; "weightBulk"; "foreign"; "Weight"); \
"dimensions"; New object:C1471("home"; "dimensions"; "foreign"; "")))


//  formula -- >> [Item]costMSC, [Item]costLastInShip, [Item]costofSales

//Manufacturer  [Item]mfrID
//Inventory ID  [Item]itemNum
//Description   [Item]description
//Product Type  [Item]type
//Price         obGeneral
//MSRP          [Item]priceMSR, [Item]priceD   
//Factor        obGeneral
//Cost          [Item]costMSC, [Item]costLastInShip, [Item]costAverage
//Status        [Item]status, 
//              Inactive [Item]dateRetired [Item]retired
//              Special Order  [Item]alertMessage
//Vendor Inventory ID   [Item]mfrItemNum
//Previous Part#   obGeneral, and cleanup
//Product Group    [Item]class
//Size Group       [Item]profile6
//Alerts           [Item]alertMessagePO
//Special Order    [Item]profile2
//    Copperfield  [Item]profile3
//freightline      [Item]profile5
//Long Description [Item]descriptionDetail
//Thumb Nail Pic   [Item]imagePathTn
//Full Image Path  [Item]imagePath
//Brochure Link    obGeneral  [Document]path
//MSDS             obGeneral  [Document]path
//Install Manual Link    obGeneral  [Document]path
//Video Link       obGeneral  [Document]path
//Weight           [Item]weightBulk  [Item]weightAverage
//MSRP             
//Forcezqz         [Item]dateLastCost  



//"formula1"; New object("method"; "Catalog_Copy"; "original"; "costMSC"; "destination"; "costAverage"); \
"formula2"; New object("method"; "Catalog_Copy"; "original"; "costMSC"; "destination"; "costLastInShip")
var vi1; vi2; vi3 : Integer
vi1:=0
vi2:=0
vi3:=0
For each ($match_o; $dataRaw_c)
	Catalog_ItemUpdate($match_o; $setup_o)
End for each 

ALERT:C41("multi: "+String:C10(vi1)+"; found: "+String:C10(vi2)+"; new: "+String:C10(vi3))
ConsoleLog("multi: "+String:C10(vi1)+"; found: "+String:C10(vi2)+"; new: "+String:C10(vi3))



$folderpath:=Get text from pasteboard:C524
$folder:=Folder:C1567($folderpath)
$files:=$folder.files()


STR_StructureWrite

If (False:C215)
	
	
	Catalog_Keyword
	
	
	
	vText1:=""
	vi2:=Records in selection:C76([ProposalLine:43])
	vText1:="Process [ProposalLine]: "+String:C10(vi2)
	CONFIRM:C162("Process [ProposalLine]: "+String:C10(vi2))
	If (ok=1)
		FIRST RECORD:C50([ProposalLine:43])
		For (vi1; 1; vi2)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
			vText1:=vText1+<>vCR+"ppLine/t"+[ProposalLine:43]itemNum:2+"/tItem/t"+[Item:4]itemNum:1+"/tIndicator7/t"+String:C10([Item:4]indicator7:101)
			[ProposalLine:43]profile1:38:=String:C10([Item:4]indicator7:101)
			SAVE RECORD:C53([ProposalLine:43])
			NEXT RECORD:C51([ProposalLine:43])
		End for 
		SET TEXT TO PASTEBOARD:C523(vText1)
	End if 
	
	var $recByID_215; $recByID_115; $recByID_old; $recByID_r; $pplLine_s; $pplLine_r : Object
	$recByID_old:=ds:C1482.Item.query("itemNum = :1"; "@-CCS")
	For each ($recByID_r; $recByID_old)
		$recByID_r.vendorID:="CCS"
		$recByID_r.vendorItemNum:=Replace string:C233($recByID_r.itemNum; "-CCS"; "")
		Case of 
			: ($recByID_r.indicator7=115)
				
			: ($recByID_r.indicator7=215)
				
			Else 
				$recByID_r.retired:=True:C214
				$recByID_r.dateRetired:=Current date:C33()
				
				$pplLine_s:=ds:C1482.ProposalLine.query("itemNum = :1"; $recByID_r.itemNum)
				For each ($pplLine_r; $pplLine_s)
					$pplLine_r.status:="retired"
					$pplLine_r.itemNumAlt:="retired"
					$pplLine_r.itemProfile1:="retired"
					$pplLine_r.save()
				End for each 
		End case 
		$recByID_r.save()
	End for each 
	
	
	// updated
	$recByID_215:=ds:C1482.Item.query("indicator7 = 215")
	
End if 





//$rec_o:=ds.TallyResult.new()
//$rec_o.name:="copperfield-2022-11-12"
//$rec_o.purpose:="catalog"
//$rec_o.dataRaw:=$dataRaw_c
//$rec_o.save()
//Else 
//$dataRaw_c:=$rec_o.dataRawata
//End if 



var $script : Text

var $tm_s; $tm_e : Object
$tm_s:=ds:C1482.TallyMaster.query("name = :1 AND purpose = :2 AND status = :3"; \
"Copperfield"; "CostUpdate"; "active")
If ($tm_s.length>0)
	$script:=$tm_s.first().script
End if 


//"line"; New object("i_item"; ""; \
"o_item"; ""; \
"mfrPart"; ""; \
"o_description"; ""; \
"i_description"; ""; \
"c_description"; ""; \
"o_cost"; 0; \
"i_cost"; 0; \
"perCent"; 0; \
"change"; 0; \
"page"; 0; \
"OrderLines"; 0; \
"POLines"; 0; \
"ProposalLines"; 0; \
"mfrItem"; ""; \
"venItem"; ""; \
"status"; ""; \
"script"; ""

$data_c:=Catalog_Match($dataRaw_c; $setup_o)



If (False:C215)
	
	var $tableName; $vtScript; $vtAddTitle : Text
	$tableName:="Order"
	$vtScript:=""  //  echo_o:=ds.Order.all()"
	$vtAddTitle:="Orders"
	var $new_o; $sel_ent : Object
	$sel_ent:=ds:C1482["Order"].all()
	$new_o:=New object:C1471("ents"; $sel_ent; \
		"cur"; $sel_ent.first(); \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"tableName"; $tableName; \
		"tableForm"; ""; \
		"form"; "OrderIncluded"; \
		"process"; Current process:C322; \
		"title"; $vtAddTitle; \
		"script"; $vtScript)
	$childProcess:=New process:C317("ProcessObject"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
End if 