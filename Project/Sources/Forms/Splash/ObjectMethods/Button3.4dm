

// HOWTO:
//FORM EDIT([Call]; "Input")

var $o : Object
$o:=New object:C1471("dataClassName"; "Item")
$processNum:=New process:C317("LBX_Importer"; 0; "LB_Import"; $o)


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



//var $data_c; $dataRaw_c : Collection
//var $setup_o : Object
//var $path_t : Text

//$path_t:="/Users/williamjames/Downloads/Copperfield/TabText.txt"
//$path_t:=Convert path POSIX to system($path_t)
//$setup_o:=New object("path"; $path_t; \
"delimitDoc"; "\r"; \
"delimitLine"; "\t"; \
"vendorSuffix"; "-CCS"; \
"line"; New object("i_item"; ""; \
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
"script"; "")



var $rec_o : Object
//$rec_o:=ds.TallyResult.query("name = :1 AND purpose = :2"; "copperfield-2022-11-12"; "catalog").first()
//If ($rec_o.dataRaw=Null)
//// harvest the data into a collection
$dataRaw_c:=Catalog_Load($setup_o)

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