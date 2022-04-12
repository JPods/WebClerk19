//%attributes = {}

// Modified by: Bill James (2021-11-06T05:00:00Z)
// Method: Task_New
// Description 
// Parameters
// ----------------------------------------------------
var $0 : Integer  // shift this to id at some point
var $1 : Object
var $2; $tableName : Text
If (Count parameters:C259>1)
	$tableName:=$2
Else 
	$tableName:=$obRec.getDataClass().tableName
End if 
// Modified by: Bill James (2021-11-06T05:00:00Z)
// add more later
var $task_ent : Object
$task_ent:=ds:C1482.Task.new()
$task_ent.obGeneral:=New object:C1471
$task_ent.obRelate:=New object:C1471("records"; New collection:C1472)
$task_ent.obRelate.records.push(New object:C1471($tableName; $1.id))
$task_ent.save()
$0:=$task_ent.idNum