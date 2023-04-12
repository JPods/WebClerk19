//%attributes = {}

// Modified by: Bill James (2022-12-13T06:00:00Z)
// Method: STR_FCNew
// Description 
// Parameters
// ----------------------------------------------------
// used to create new FC records for listboxes, entry forms, and others TBD

#DECLARE($ref : Object)->$rec : Object

$fc_o:=ds:C1482.FC.new()
$fc_o.purpose:=$ref.purpose  // listbox, entry, other
$fc_o.dataClassName:=$ref.dataClassName
$fc_o.name:=$ref.name  //name of the listbox, entry subform, etc....
If ($ref.securityLevel=Null:C1517)
	$fc_o.securityLevel:=1
Else 
	$fc_o.securityLevel:=$ref.securityLevel
End if 
If ($ref.obGeneral=Null:C1517)
	$fc_o.obGeneral:=Init_obGeneral
Else 
	$fc_o.obGeneral:=$ref.obGeneral
End if 
// set up in the calling class
$fc_o.data:=$ref.data

$fc_o.save()
$id:=$fc_o

