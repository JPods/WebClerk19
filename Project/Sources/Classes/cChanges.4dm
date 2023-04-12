
// Modified by: Bill James (2022-06-17T05:00:00Z)
// Method: cChanges
// Description 
// Parameters
// ----------------------------------------------------
Class constructor($process_o : Object; $entry_o : Object; $action : Text)
	ASSERT:C1129(Count parameters:C259>=1; "The name of the dataClass is required.")
	
	// every obGeneral should have an id_TallyChange
	If ($entry_o.obGeneral=Null:C1517)
		$entry_o.obGeneral:=Init_obGeneral
		$entry_o.changed:=True:C214
	End if 
	
	If ($entry_o.obGeneral.id_TallyChange=Null:C1517)
		$entry_o.obGeneral.id_TallyChange:=""
	End if 
	
	var $return : Object
	// set to null to check if entity is in hand
	$return:=Null:C1517
	
	// if no record exists, create one and fill the id_TallyChange
	If ($entry_o.obGeneral.id_TallyChange="")
		//$return:=This.createTallyChange()
		This:C1470.TallyChange:=ds:C1482.TallyChange.new()
		$return.tableName:=$process_o.dataClassName
		$return.idKey:=$entry_o.id
		$return.dtCreated:=DateTime_DTTo
		// create a collection to save changes
		$return.obHistory:=New object:C1471("changes"; New collection:C1472)
		$return.save()
		$entry_o.obGeneral.id_TallyChange:=$return.id
		$entry_o.changed:=True:C214
	End if 
	
	// get the entity
	If ($return=Null:C1517)
		$return:=ds:C1482.TallyChange.query("id = :1"; entry_o.obGeneral.TallyChange_id).first()
	End if 
	
	//$return.dataClassName:=$process_o.dataClassName
	//$return.action:=$action
	
	If ($process_o.dataClassNameLines="")
		$return.obHistory.changes.push(New object:C1471("date"; Current date:C33; "user"; Current user:C182; "entity"; entry_o))
	Else 
		$return.obHistory.changes.push(New object:C1471("date"; Current date:C33; "user"; Current user:C182; "entity"; entry_o; "lines"; LB_Lines.ents))
	End if 
	
	$return.save()
	This:C1470.data:=$return
	
Function createTallyChange()
	$return:=ds:C1482.TallyChange.new()
	$return.tableName:=This:C1470.dataClassName
	$return.idKey:=$entry_o.id
	$return.dtCreated:=DateTime_DTTo
	// create a collection to save changes
	$return.obHistory:=New object:C1471("changes"; New collection:C1472)
	$return.save()
	$entry_o.obGeneral.TallyChange_id:=$return.id
	$entry_o.changed:=True:C214
	
Function saveArchive($process_o : Object)
	If ($process_o.dataClassNameLines="")
		$return.obHistory.changes.push(New object:C1471("date"; Current date:C33; "user"; Current user:C182; "entity"; entry_o))
	Else 
		$return.obHistory.changes.push(New object:C1471("date"; Current date:C33; "user"; Current user:C182; "entity"; entry_o; "lines"; LB_Lines.ents))
	End if 
	$return.save()
	