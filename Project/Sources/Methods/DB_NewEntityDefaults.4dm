//%attributes = {}

// Modified by: Bill James (2022-01-21T06:00:00Z)
// Method: DB_NewEntityDefaults
// Description 
// Parameters
// ----------------------------------------------------


var $tableName; $1 : Text
var entryEntity; $rec_o; $o : Object
If (process_o.cur=Null:C1517)
	$tableName:=$1
	entryEntity:=New object:C1471
	Case of 
		: ($tableName="Customer")
			entryEntity:=DBCustomer_init
		: ($tableName="Item")
			$o:=New object:C1471
			$rec_o:=DBItem_Init($o)
		Else 
			$rec_o:=ds:C1482[$tableName].new()
			$rec_o.save()
			entryEntity:=$rec_o.toObject()
	End case 
	process_o.cur:=$rec_o
	process_o.old:=process_o.cur.clone()
Else 
	entryEntity:=process_o.cur.toObject()
End if 