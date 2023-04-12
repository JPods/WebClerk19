//%attributes = {}

// Modified by: Bill James (2022-03-25T05:00:00Z)
// Method: EntityLoad
// Description 
// Parameters
// ----------------------------------------------------
var $1; $o : Object
$o:=$1
// capture the selected dataLine
process_o.dataClassName:=$o.tableName
process_o.id:=$o.id
ptCurTable:=STR_GetTablePointer($o.tableName)
// OBJECT SET SUBFORM(*; "SF_Input"; ptCurTable->; "InputDS")  // load the SF

// get the record
process_o.cur:=ds:C1482[$o.tableName].get($o.id)

process_o.cur:=ds:C1482[$o.tableName].query("id = "+cServiceAction.cur.id).first()
process_o.old:=process_o.cur.clone()
// use entry_o as a sort of class in all InputDS. add additional variables as needed.

// save entry_o back to the
// make the working entity and set its tableName
var entry_o : Object
entry_o:=New object:C1471
entry_o:=process_o.cur.toObject()
//process_o.entry_o.tableName:=$o.tableName
