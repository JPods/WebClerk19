//%attributes = {}

// Modified by: Bill James (2021-11-15T06:00:00Z)
// Method: KeyTags_MakeByObject
// Description 
// Parameters
// ----------------------------------------------------
var $1; $rec_ent : Object
$rec_ent:=$1

var $keyText_c; $alpha_c : Collection
$alpha_c:=New collection:C1472
$keyText_c:=New collection:C1472
If ($rec_ent.keyTags#Null:C1517)
	$keyText_c:=Split string:C1554($rec_ent.obGeneral.keyText; ";")
End if 
If ($rec_ent.keyText#Null:C1517)
	$existingKeyWords:=$rec_ent.keyText
End if 
If ($rec_ent.obGeneral=Null:C1517)
	
End if 




