//%attributes = {}

// Modified by: Bill James (2022-01-13T06:00:00Z)
// Method: SF_Sales_Execute
// Description 
// Parameters
// ----------------------------------------------------
var $o; $obParent : Object
$o:=$1
LB_Included:=New object:C1471("ents"; New object:C1471; "sel"; New object:C1471; "cur"; New object:C1471; "pos"; -1)
LB_Included.ents:=ds:C1482[$o.tableName].query("customerID = :1"; $o.id)
19TestFillAll(LB_Included.ents)
