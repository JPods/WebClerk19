//%attributes = {}

// Modified by: Bill James (2021-12-08T06:00:00Z)
// Method: KeyTag_RebuildThisRecord
// Description 
// Parameters
// ----------------------------------------------------



var $reload : Boolean
$reload:=False:C215
If (Record number:C243(ptCurTable->)#-1)
	SAVE RECORD:C53(ptCurTable->)
	$reload:=True:C214
End if 
var $ptID; $ptObGeneral; $ptkeyTags : Pointer
var $tableName; $keyTags; $id_t : Text
var $rec_ent : Object
$tableName:=Table name:C256(ptCurTable)
$ptID:=STR_Get_idPointer($tableName)
$id_t:=$ptID->
UNLOAD RECORD:C212(ptCurTable->)

$rec_ent:=ds:C1482[Table name:C256(ptCurTable)].query("id = :1"; $id_t).first()

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

If ($reload)
	LOAD RECORD:C52(ptCurTable->)
End if 

