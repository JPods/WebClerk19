//%attributes = {}
//
// Modified by: Bill James (2021-11-15T06:00:00Z)
// Method: 00Fix_KeyTag_Delete
// Description 
// Parameters
// ----------------------------------------------------
// 

var $rec_ent; $sel_ent; $dataClass_o : Object
var $tables_c : Collection
var $tableName : Text
//$tables_c:=Split string("Customer;Item;Order;Vendor"; ";")
var $inc; $cnt : Integer
$cnt:=Get last table number:C254
For ($inc; 1; $cnt)
	$tableName:=Table name:C256($inc)
	If ($tableName#"zz@")
		$sel_ent:=ds:C1482[$tableName].all()
		$dataClass_o:=$sel_ent.getDataClass()
		If ($dataClass_o.obGeneral=Null:C1517)
			$rec_ent.obGeneral:=New object:C1471("keyTags"; ""; "keyText"; "")
		End if 
		
		ConsoleLog("Table: "+$tableName+", count: "+String:C10($sel_ent.length))
		For each ($rec_ent; $sel_ent)
			$rec_ent.obGeneral:=New object:C1471("keyTags"; ""; "keyText"; ""; "id_TallyChange"; "")
			If ($rec_ent.obGeneral#Null:C1517)  // seens to be some corrupt records
				If ($rec_ent.deleteText#Null:C1517)
					$rec_ent.obGeneral.keyText:=KeyWordCleanup($rec_ent.deleteText)
					$rec_ent.deleteText:=""
				End if 
				$rec_ent.obGeneral.keyTags:=KeyTagsFromAlphaFields($rec_ent)
				If ($rec_ent.keyTags#Null:C1517)
					$rec_ent.keyTags:=$rec_ent.obGeneral.keyTags
				End if 
				$rec_ent.save()
			End if 
		End for each 
	End if 
End for 
ConsoleLog("Complete keyTags")
