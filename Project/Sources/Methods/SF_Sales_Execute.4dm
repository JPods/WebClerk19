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

If (LB_Included.ents.length=0)
	//19TestFillAll(LB_Included.ents)
End if 

If (LB_Included.ents.length>0)
	LB_Included.cur:=LB_Included.ents[0]
	LB_Included.sel:=LB_Included.ents[0]
	LB_Included.pos:=1
	LISTBOX SELECT ROW:C912(*; "LB_Included"; 1)
	OBJECT SET SCROLL POSITION:C906(*; "LB_Included"; 1)
End if 