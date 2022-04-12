//%attributes = {}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: DB_RecordReturnObject
// Description 
// Parameters
// ----------------------------------------------------
var $0 : Object
var $1 : Text
$0:=ds:C1482[$1].query("id = :1"; STR_Get_idPointer($1)->).first()
