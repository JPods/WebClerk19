//%attributes = {}

// Modified by: Bill James (2022-04-05T05:00:00Z)
// Method: DE_obGeneralTest
// Description 
// Parameters
// ----------------------------------------------------
var $1; $rec_ent : Object
$rec_ent:=$1
If ($rec_ent.obGeneral=Null:C1517)
	$rec_ent.obGeneral:=Init_obGeneral
End if 
If ($rec_ent.obGeneral.keyTags=Null:C1517)
	$rec_ent.obGeneral.keyTags:=""
End if 
If ($rec_ent.obGeneral.keyText=Null:C1517)
	$rec_ent.obGeneral.keyText:=""
End if 
