//%attributes = {}

// Modified by: Bill James (2021-12-06T06:00:00Z)
// Method: KeyTag_RebuildTable
// Description 
// Parameters
// ----------------------------------------------------
// KeyTag_RebuildTable("Customer")
var $1; $tableName; $keyTags; $id_t : Text
var $rec_ent; $sel_ent : Object
var $temp_o : Object
var $inc; $cnt : Integer
$cnt:=1
If (Count parameters:C259=0)
	$cnt:=Get last table number:C254
	For ($inc; 2; $cnt)
		$tableName:=Table name:C256($inc)
		If (($tableName="zz@") | ($tableName="Control") | ($tableName="Default"))
			// not build
		Else 
			KeyTag_RebuildTable($tableName)
		End if 
	End for 
	ConsoleMessage("KeyTags complete for all tables.")
Else 
	var $rec_ent; $sel_ent; $temp_o : Object
	$tableName:=$1
	$sel_ent:=ds:C1482[$tableName].all()
	For each ($rec_ent; $sel_ent)
		$keyTags:=KeyTagsFromAlphaFields($rec_ent)
		$temp_o:=New object:C1471("keyTags"; ""; "keyText"; ""; "backup"; "")
		If ($rec_ent.obGeneral.keytext#Null:C1517)
			$temp_o.keyText:=$rec_ent.obGeneral.keytext
			$temp_o.backup:=$rec_ent.obGeneral.keytext
		End if 
		If ($rec_ent.obGeneral.keyText#Null:C1517)
			$temp_o.keyText:=$rec_ent.obGeneral.keyText
		End if 
		$temp_o.keyTags:=$keyTags
		$rec_ent.obGeneral:=$temp_o
		$rec_ent.save()
	End for each 
	ConsoleMessage("KeyTags: "+$tableName)
End if 


If (False:C215)
	var $rec_ent; $sel_ent; $temp_o : Object
	var vText1 : Text
	var vi1 : Integer
	//$sel_ent:=ds.Item.all()
	$sel_ent:=Create entity selection:C1512([Item:4])
	vi1:=0
	For each ($rec_ent; $sel_ent)
		
		
		
		
		$rec_ent.obGeneral:=$temp_o
		$rec_ent.save()
		vText1:=KeyTagsFromAlphaFields($rec_ent)
		$rec_ent.obGeneral.keyTags:=vText1
		$rec_ent.keyTags:=vText1
		$rec_ent.save()
		
	End for each 
End if 
