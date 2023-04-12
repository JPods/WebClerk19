//%attributes = {}

// Modified by: Bill James (2022-11-18T06:00:00Z)
// Method: Catalog_Keyword
// Description 
// Parameters
// ----------------------------------------------------

var $outPut_t; $line_t : Text
$outPut_t:="itemNum\tkeyTags\taction\r"
var $selection_o; $record_o : Object
$selection_o:=ds:C1482.Item.all()
For each ($record_o; $selection_o)
	If ($record_o.keyTags="")
		$record_o.obGeneral:=Init_obGeneral
		$record_o.obGeneral.keyTags:=KeyTagsFromAlphaFields($record_o)
		If ($record_o.keyTags#Null:C1517)
			$record_o.keyTags:=$record_o.obGeneral.keyTags
		End if 
		$record_o.save()
	End if 
	$line_t:=$record_o.itemNum+"\t"+\
		$record_o.keyTags+"\t"+\
		$record_o.action+"\r"
	$outPut_t:=$outPut_t+$line_t
End for each 
SET TEXT TO PASTEBOARD:C523($outPut_t)
vText3:="/Users/williamjames/Documents/CommerceExpert/act/2022/keyword_2022-11-18/keywords_2022-11-18.txt"
vText3:=Convert path POSIX to system:C1107(vText3)

myDoc:=Open document:C264("")
var coll_c; line_c : Collection
var item_o : Object
vText1:=""
vText2:=""
If (OK=1)
	CLOSE DOCUMENT:C267(myDoc)
	vText1:=Document to text:C1236(document)
	coll_c:=Split string:C1554(vText1; "\r")
	
	ALERT:C41("Items: "+String:C10(coll_c.length))
	For each (vText2; coll_c)
		line_c:=Split string:C1554(vText2; "\t")
		item_o:=ds:C1482.Item.query("itemNum = :1"; line_c[0]).first()
		If (item_o#Null:C1517)
			item_o.keyTags:=line_c[1]
			If (item_o.obGeneral=Null:C1517)
				item_o.obGeneral:=New object:C1471("keyTags"; ""; \
					"keyText"; "")
			End if 
			item_o.obGeneral.keyTags:=item_o.keyTags
			item_o.save()
		End if 
	End for each 
	
	
End if 
ALERT:C41("Complete")

