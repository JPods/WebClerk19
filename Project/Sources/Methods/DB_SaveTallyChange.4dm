//%attributes = {}

// Modified by: Bill James (2022-06-28T05:00:00Z)
// Method: DB_SaveTallyChange
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($process_o : Object; $entry_o : Object; $tallyChange : Object)->$return : Object

// junk

If ($entry_o#Null:C1517)
	// every obGeneral should have an id_TallyChange
	If ($entry_o.obGeneral=Null:C1517)
		$entry_o.obGeneral:=Init_obGeneral
		$entry_o.changed:=True:C214
	End if 
	
	If ($entry_o.obGeneral.id_TallyChange=Null:C1517)
		$entry_o.obGeneral.id_TallyChange:=""
	End if 
	
	var $return : Object
	$return:=Null:C1517
	// set to null to check if entity is in hand
	If ($tallyChange#Null:C1517)
		$return:=$tallyChange
	End if 
	
	// if no record exists, create one and fill the id_TallyChange
	If ($entry_o.obGeneral.id_TallyChange="")
		$return:=ds:C1482.TallyChange.new()
		$return.tableName:=$process_o.dataClassName
		$return.idKey:=$entry_o.id
		$return.dtCreated:=DateTime_DTTo
		// create a collection to save changes
		$return.obHistory:=New object:C1471("changes"; New collection:C1472)
		$return.save()  // not really necessary
		$entry_o.obGeneral.id_TallyChange:=$return.id
		$entry_o.changed:=True:C214
	End if 
	
	
	
	//$return.dataClassName:=$process_o.dataClassName
	//$return.action:=$action
	
	
	
	If ($process_o.dataClassNameLines="")
		$return.obHistory.changes.push(New object:C1471("date"; Current date:C33; "user"; Current user:C182; "entity"; entry_o))
	Else 
		$return.obHistory.changes.push(New object:C1471("date"; Current date:C33; "user"; Current user:C182; "entity"; entry_o; "lines"; LB_Lines.ents))
	End if 
	$return.save()
End if 

