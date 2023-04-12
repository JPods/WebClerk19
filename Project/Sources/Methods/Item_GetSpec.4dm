//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: Item_GetSpec
// Description 
// Parameters
// ----------------------------------------------------
var $spec_o : Object
Case of 
	: (process_o.cur=Null:C1517)
		// do nothing
		
	: (process_o.cur.specid="")
		$spec_o:=ds:C1482.ItemSpec.query("itemNum = :1"; process_o.cur.itemNum).first()
	Else 
		$spec_o:=ds:C1482.ItemSpec.query("itemNum = :1"; process_o.cur.specid).first()
End case 
If ($spec_o#Null:C1517)
	If ($spec_o.length>0)
		process_o.cur.ItemSpec:=$spec_o
	End if 
	ImageGetPict
End if 
